extends CharacterBody2D


signal damaged(by)
signal died()


enum{
	ACID,
	TELEPORT,
	EXPLOSION
}


const SPEED = 200.0
const MAX_HP = 100.0
var currentHP = MAX_HP

var currentPotion = EXPLOSION

var click_position = Vector2()
var target_position = Vector2()

@onready var potionReference = $Potion

func _physics_process(delta):
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
		
		
		if currentPotion == TELEPORT:
			if Input.is_action_just_pressed("left_click"): # Teleport
				potionReference.time += delta
				var direction = (get_global_mouse_position() - global_position)
				var distance = get_global_mouse_position().distance_to(global_position)
				potionReference.throwPotion(global_position, direction, distance, 60)
				
				if potionReference.is_launch:
					potionReference.z_axis = potionReference.initial_speed + sin(deg_to_rad(potionReference.throw_angle_degrees)) * potionReference.time - 0.5 * potionReference.gravity * pow(potionReference.time,2)
					
				if potionReference.z_axis > 0:
					var x_axis: float = potionReference.initial_speed * cos(deg_to_rad(potionReference.throw_angle_degrees)) * potionReference.time
					potionReference.global_position = potionReference.initial_position + potionReference.throw_direction * x_axis
					potionReference.global_position.y = -potionReference.z_axis
					
				position = get_global_mouse_position()
				move_and_slide()
			
		if Input.is_action_just_pressed("acid_potion"):
			print("Acid Potion")
			currentPotion = ACID
		elif Input.is_action_just_pressed("explosion_potion"):
			print("Explosion Potion")
			currentPotion = EXPLOSION
		elif Input.is_action_just_pressed("teleport_potion"):
			print("Teleport Potion")
			currentPotion = TELEPORT



func _input(event):
	if Engine.time_scale == 1:
		if event.is_action_pressed("ui_up"):
			$AnimatedSprite2D.play("MoveUp")
		elif event.is_action_pressed("ui_down"):
			$AnimatedSprite2D.play("MoveDown")
		elif event.is_action_pressed("ui_right"):
			$AnimatedSprite2D.play("MoveRight")
		elif event.is_action_pressed("ui_left"):
			$AnimatedSprite2D.play("MoveLeft")
		else:
			if event.is_action_released("ui_up"):
				$AnimatedSprite2D.play("Idle(Back)")
			elif event.is_action_released("ui_down"):
				$AnimatedSprite2D.play("Idle(Screen)")
			elif event.is_action_released("ui_right"):
				$AnimatedSprite2D.play("Idle(Right)")
			elif event.is_action_released("ui_left"):
				$AnimatedSprite2D.play("Idle(Left)")

func take_damage(impact):
	var damage = int(impact)
	var previousHP = currentHP
	currentHP -= damage
	currentHP = clamp(currentHP, 0, MAX_HP)
	
	if previousHP != currentHP:
		emit_signal("damaged", damage)
		
	if currentHP <= 0:
		emit_signal("died")
		get_tree().reload_current_scene()
