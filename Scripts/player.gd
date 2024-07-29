extends CharacterBody2D

signal damaged(by)
signal died()

enum {
	ACID,
	TELEPORT,
	EXPLOSION
}

var potionCooldowns = { # Potion cooldowns for each potion type
	ACID: 3.0,
	TELEPORT: 5.0,
	EXPLOSION: 2.0
}

var lastPotionUseTimes = {
	ACID: -99.0,
	TELEPORT: -99.0,
	EXPLOSION: -99.0
}


const SPEED = 120
const MAX_HP = 100.0
var currentHP = MAX_HP

var currentPotion = EXPLOSION

var potion

var click_position = Vector2()
var target_position = Vector2()

@onready var potionScene = preload("res://Scenes/potion.tscn")
@onready var sprite_2d = $Sprite2D

func _physics_process(_delta):
	if Engine.time_scale == 1:
		var direction_x = Input.get_axis("ui_left", "ui_right")
		var direction_y = Input.get_axis("ui_up", "ui_down")
		if direction_x:
			velocity.x = direction_x * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if direction_y:
			velocity.y = direction_y * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
		move_and_slide()
		if Input.is_action_just_pressed("left_click"):
			if can_use_potions(currentPotion):
				use_potion(currentPotion)
			
		if Input.is_action_just_pressed("acid_potion"):
			print("Acid Potion")
			currentPotion = ACID
		elif Input.is_action_just_pressed("explosion_potion"):
			print("Explosion Potion")
			currentPotion = EXPLOSION
		elif Input.is_action_just_pressed("teleport_potion"):
			print("Teleport Potion")
			currentPotion = TELEPORT
	#ANIMATIONS------------------------------------------------
	var char_velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		char_velocity.x += 1.0
	if Input.is_action_pressed("ui_left"):
		char_velocity.x -= 1.0
	if Input.is_action_pressed("ui_down"):
		char_velocity.y += 1.0
	if Input.is_action_pressed("ui_up"):
		char_velocity.y -= 1.0
	char_velocity = char_velocity.normalized()
	if char_velocity == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("Idle")
	else:
		$AnimationTree.get("parameters/playback").travel("Walk")
		$AnimationTree.set("parameters/Idle/blend_position", char_velocity)
		$AnimationTree.set("parameters/Walk/blend_position", char_velocity)
	#ANIMATIONS----------------------------------------------
func take_damage(impact):
	var damage = int(impact)
	var previousHP = currentHP
	currentHP -= damage
	currentHP = clamp(currentHP, 0, MAX_HP)
	
	sprite_2d.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	sprite_2d.modulate = Color.WHITE
	
	if previousHP != currentHP:
		emit_signal("damaged", damage)
		
	if currentHP <= 0:
		emit_signal("died")
		get_tree().reload_current_scene()
		
		
func can_use_potions(potionType) -> bool: # Checks whether the potion is available to use
	var current_time = Time.get_ticks_msec() / 1000.0
	var last_use_time = lastPotionUseTimes[potionType]
	var cooldown = potionCooldowns[potionType]
	return current_time - last_use_time >= cooldown
	
	
func use_potion(potionType): # Use the potion
	if get_tree().get_current_scene().name == "Dungeon":
		target_position = get_global_mouse_position()
		var direction = (target_position - global_position)
		var distance = target_position.distance_to(global_position)

		potion = potionScene.instantiate()
		get_parent().add_child(potion)

		potion.global_position = global_position
		potion.target_position = target_position
		potion.LaunchProjectile(global_position, direction, distance, 60)

		if currentPotion == TELEPORT:
			potion.potionType = TELEPORT
			potion.playerReference = self
			potion.animated_sprite_2d.play("ThrowTeleport")
		elif currentPotion == ACID:
			potion.potionType = ACID
			potion.animated_sprite_2d.play("ThrowAcid")
		elif currentPotion == EXPLOSION:
			potion.potionType = EXPLOSION
			potion.animated_sprite_2d.play("ThrowExplosion")
			
		lastPotionUseTimes[currentPotion] = Time.get_ticks_msec() / 1000.0
