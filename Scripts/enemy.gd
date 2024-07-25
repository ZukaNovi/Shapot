extends CharacterBody2D


@onready var player = get_node("/root/Game/Player")
@onready var collision = $CollisionShape2D

var health: int = 100

func _ready():
	add_to_group("enemies")

func _physics_process(delta):
	var distance_to_player = sqrt(pow(global_position.x - player.global_position.x,2)
	+ pow(global_position.y - player.global_position.y,2))
	
	if distance_to_player < 250.0:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * 100.0
		move_and_slide()
		
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		if collision_info.get_collider() == player:
			player.take_damage(20)
	print(health)


func take_damage(damage: int):
	health -= damage
	if health <= 0:
		die()
		
func die():
	queue_free()
