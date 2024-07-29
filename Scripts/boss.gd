extends CharacterBody2D

signal damaged(by)
signal died()

@onready var player = get_node("/root/Dungeon/Player")
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var attack_timer = $AttackTimer
@onready var damage_area = $DamageArea
@onready var boss_health_bar = $"../CanvasLayer/BossHealthBar"
@onready var drop_item = $DropItem

const MAX_HP = 150

var currentHP = MAX_HP
var bossSpeed: float = 100.0
var direction: Vector2
var bossDamage = 40

var canChase = true

var playerFound = false

func _ready():
	add_to_group("enemies")
	
	
	
func _physics_process(_delta):
	var distance_to_player = global_position.distance_to(player.global_position)
	
	if distance_to_player < 200 && canChase:
		playerFound = true
		direction = global_position.direction_to(player.global_position)
		velocity = direction * bossSpeed
		if direction.x > 0:
			animated_sprite_2d.play("MoveRight")
		elif direction.x < 0:
			animated_sprite_2d.play("MoveLeft")
		if direction.y > 0:
			animated_sprite_2d.play("MoveDown")
		elif direction.y < 0:
			animated_sprite_2d.play("MoveUp")
		elif direction.x == 0 and direction.y == 0:
			animated_sprite_2d.play("Idle")
		move_and_slide()
		
	if playerFound:
		boss_health_bar.show()

func take_damage(impact):
	var damage = int(impact)
	var previousHP = currentHP
	currentHP -= damage
	currentHP = clamp(currentHP, 0, MAX_HP)
	
	animated_sprite_2d.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	animated_sprite_2d.modulate = Color.WHITE
	
	if previousHP != currentHP:
		emit_signal("damaged", damage)
		
	if currentHP <= 0:
		emit_signal("died")
		die()
		
func die():
	boss_health_bar.hide()
	queue_free()

func attack():
	player.take_damage(bossDamage)
	canChase = false
	attack_timer.start()

func _on_damage_area_body_entered(body):
	if body == player:
		attack()
		attack_timer.start()
		canChase = false

func _on_attack_timer_timeout():
	canChase = true
	if damage_area.get_overlapping_bodies().has(player):
		attack()
		
func dropItem():
	drop_item.visible = true

func _on_area_2d_body_entered(body):
	if drop_item.visible == true:
		if body == player:
			player.hasItem = true
			print(player.hasItem)
			drop_item.queue_free()
