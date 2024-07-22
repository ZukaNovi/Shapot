extends Node2D

@onready var pause_menu = $Player/PauseMenu
@onready var canvas_modulate = $TileMap/CanvasModulate
@onready var point_light_2d = $PointLight2D

var paused = false

func _process(delta):
	if Input.is_action_just_pressed("escape"):
		pauseMenu()
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0

	paused = !paused		
