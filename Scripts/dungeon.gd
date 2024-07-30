extends Node2D

@onready var pause_menu = $CanvasLayer/PauseMenu
@onready var day_night_cycle = $DayNightCycle
@onready var dungeon_entry = $DungeonEntry
@onready var boss_health_bar = $CanvasLayer/BossHealthBar
@onready var item = $Item
@onready var boss = $Boss
@onready var player = $Player
@onready var dungeon_music = $DungeonMusic
var music_playing = true

var bossLastPosition: Vector2

var paused = false
func _ready():
	ConfigFileHandler.count_scene = 1 + ConfigFileHandler.count_scene
	dungeon_entry.scene_name = "Dungeon"
	dungeon_music.play()
	await get_tree().create_timer(40).timeout
	dungeon_music.play()
	await get_tree().create_timer(40).timeout
	dungeon_music.play()
	await get_tree().create_timer(40).timeout
	dungeon_music.play()
	await get_tree().create_timer(40).timeout
	dungeon_music.play()
	await get_tree().create_timer(40).timeout
	dungeon_music.play()
	await get_tree().create_timer(40).timeout
	dungeon_music.play()
	

func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		pauseMenu()
	if boss != null:
		bossLastPosition = boss.global_position
	if boss == null:
		if item != null:
			item.global_position = bossLastPosition
			item.show()
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0

	paused = !paused		

func _on_area_2d_body_entered(body):
	if body == player:
		ConfigFileHandler.playerHasItem = true
		item.queue_free()
