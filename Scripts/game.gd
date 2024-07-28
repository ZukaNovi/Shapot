extends Node2D

@onready var pause_menu = $CanvasLayer/PauseMenu
@onready var day_night_cycle = $DayNightCycle

var paused = false
func _ready():
	if ConfigFileHandler.count_scene == 2:
		day_night_cycle.scene_name = "Game"
		ConfigFileHandler.count_scene = 0
	ConfigFileHandler.count_scene = 1 + ConfigFileHandler.count_scene
func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		print("zort")
		pauseMenu()
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0

	paused = !paused
