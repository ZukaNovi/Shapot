extends CharacterBody2D


@onready var player = get_node("/root/Game/Player")


func _physics_process(delta):
	var distance_to_player = sqrt(pow(global_position.x - player.global_position.x,2)
	+ pow(global_position.y - player.global_position.y,2))
	
	if distance_to_player < 250.0:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * 200.0
		move_and_slide()
		
	
