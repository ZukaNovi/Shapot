extends Node2D
@onready var animated_sprite_2d = $AnimatedSprite2D

var initial_speed: float
var throw_angle_degrees: float
const gravity: float = 9.8
var time: float = 0.0

var initial_position: Vector2
var throw_direction: Vector2
var target_position: Vector2

var z_axis = 0.0 # Simulate throwing the projectile on the z-axis by adding the z-axis to the y-axis
var is_launch: bool = false

var time_mult: float = 6.0
func _process(delta):
	time += delta * time_mult
	show()
	#print(global_position.x)
	if get_parent().currentPotion == get_parent().TELEPORT:
		animated_sprite_2d.play("ThrowTeleport")
	if get_parent().currentPotion == get_parent().ACID:
		animated_sprite_2d.play("ThrowAcid")
		#print("acid animation")
	if get_parent().currentPotion == get_parent().EXPLOSION:
		animated_sprite_2d.play("ThrowExplosion")	
	if is_launch:
		z_axis = initial_speed * sin(deg_to_rad(throw_angle_degrees)) * time - 0.5 * gravity * pow(time, 2)
		
		# If has not touched the ground yet
		if z_axis > 0:
			var x_axis: float = initial_speed * cos(deg_to_rad(throw_angle_degrees)) * time
			global_position = initial_position + throw_direction * x_axis ## Move everything along the 'x-axis'
			
			$AnimatedSprite2D.position.y = -z_axis # Move only the projectile along the y axis based on the simulated z-axis
	if int(abs(global_position.x - target_position.x)) == 0 && int(abs(global_position.y - target_position.y)) == 0: 
		if get_parent().currentPotion == get_parent().TELEPORT:
			get_parent().global_position = target_position
		if get_parent().currentPotion == get_parent().ACID:
			animated_sprite_2d.play("AcidPool")
		#hide()
		
func LaunchProjectile(initial_pos: Vector2, direction: Vector2, desired_distance: float, desired_angle_deg: float):
	initial_position = initial_pos
	throw_direction = direction.normalized()
	
	throw_angle_degrees = desired_angle_deg
	# Find initial speed based on desired distance (R) and desired angle (theta)
	initial_speed = pow(desired_distance * gravity / sin(2 * deg_to_rad(desired_angle_deg)), 0.5)
	
	global_position = initial_position
	time = 0.0
	
	z_axis = 0
	is_launch = true
