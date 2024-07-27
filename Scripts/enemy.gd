extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")
@onready var collision = $CollisionShape2D
@onready var damageArea = $DamageArea
@onready var attack_timer = $AttackTimer

var health: int = 100
var enemySpeed: float = 70.0
var direction: Vector2
var enemyDamage = 20


var patrol_direction: Vector2 = Vector2.RIGHT
var patrol_range: float = 40.0
var patrol_start_position: Vector2
var patrol_speed: float = 20.0

var canAttack: bool = true
var isChasing: bool = true

func _ready():
	add_to_group("enemies")

func _physics_process(delta):
	var distance_to_player = global_position.distance_to(player.global_position)
	
	if distance_to_player < 250.0:
		direction = global_position.direction_to(player.global_position)
		velocity = direction * enemySpeed
		move_and_slide()
		isChasing = true
	else:
		if isChasing:
			patrol_start_position = global_position
			isChasing = false
		patrol(delta)
		
	var unitDirection = direction / direction.length()
	if unitDirection != Vector2.ZERO: 
		$AnimationTree.get("parameters/playback").travel("Move")
		$AnimationTree.set("parameters/Walk/blend_position", unitDirection)

func take_damage(damage: int):
	health -= damage
	if health <= 0:
		die()
		
func die():
	queue_free()

func patrol(delta):
	if patrol_direction == Vector2.RIGHT and global_position.x >= patrol_start_position.x + patrol_range:
		patrol_direction = Vector2.LEFT
	elif patrol_direction == Vector2.LEFT and global_position.x <= patrol_start_position.x - patrol_range:
		patrol_direction = Vector2.RIGHT

	velocity = patrol_direction * patrol_speed
	move_and_slide()

func _on_damage_area_body_entered(body):
	if body == player and canAttack:
		attack()
		attack_timer.start()
		

func _on_damage_area_body_exited(body):
	if body == player:
		attack_timer.stop()
		canAttack = true
		
func attack():
	print("Dealt damage")
	player.take_damage(enemyDamage)
	canAttack = false
	attack_timer.start()

func _on_attack_timer_timeout():
	canAttack = true
	if damageArea.get_overlapping_bodies().has(player):
		attack()
