extends Node2D

@onready var pause_menu = $Player/PauseMenu
@onready var point_light_2d = $PointLight2D
@onready var dungeon_entry = $DungeonEntry

var paused = false
func _ready():
	dungeon_entry.scene_name = "Game"

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
