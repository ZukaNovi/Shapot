extends Node2D

@onready var pause_menu = $Player/PauseMenu
@onready var dungeon_entry = $DungeonEntry


var paused = false
# Called when the node enters the scene tree for the first time.
func _ready():
	dungeon_entry.scene_name = "Village"

func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		pauseMenu()
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		
	paused = !paused
