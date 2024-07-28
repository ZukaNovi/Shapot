extends CharacterBody2D

@onready var player = get_node("/root/Dungeon/Player")
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var attack_timer = $AttackTimer
@onready var damage_area = $DamageArea

var health: int = 150
var bossSpeed: float = 100.0
var direction: Vector2
var bossDamage = 40

var canChase = true



func _ready():
	add_to_group("enemies")
	
	
	
func _physics_process(delta):
	var distance_to_player = global_position.distance_to(player.global_position)
	
	if distance_to_player < 250 && canChase:
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

func take_damage(damage):
	health -= damage
	if health <= 0:
		die()
		
func die():
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
		
