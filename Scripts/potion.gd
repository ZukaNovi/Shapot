extends Node2D

var initial_speed: float
var throw_angle_degrees: float
const gravity: float = 9.8
var time: float = 0.0

var initial_position: Vector2
var throw_direction: Vector2

var z_axis: float = 0.0
var is_launch: bool = false

@onready var potion = $AnimatedSprite2D

func throwPotion(initial_pos: Vector2, direction: Vector2, desired_distance: float, desired_angle_deg: float):
	show()
	print("Throw potion")
	potion.play("ThrowTeleport")
	initial_position = initial_pos
	throw_direction = direction.normalized()
	
	throw_angle_degrees = desired_angle_deg
	
	initial_speed = pow(desired_angle_deg * gravity / sin(2 * deg_to_rad(desired_angle_deg)), 0.5)
	
	global_position = initial_position
	time = 0.0
	
	z_axis = 0
	is_launch = true
