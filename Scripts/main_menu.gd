extends Control
@onready var audio_stream_player = $AudioStreamPlayer

func _ready():
	$AudioStreamPlayer.play()
	var audio_settings = ConfigFileHandler.load_audio_settings()
	var normalized_value = clamp(audio_settings.master_volume,0.0,1.0)
	var db_value = -40 + (normalized_value * 60) # [-40,20]
	audio_stream_player.volume_db = db_value
	

func _on_start_button_pressed():
	Engine.time_scale = 1
	ConfigFileHandler.save_dialog_settings(0)
	ConfigFileHandler.save_quest_settings("quest1",0)
	ConfigFileHandler.save_quest_settings("quest2",0)
	ConfigFileHandler.save_quest_settings("quest3",0)
	ConfigFileHandler.save_quest_settings("quest4",0)
	ConfigFileHandler.playerHasItem = false
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/options_menu.tscn")


func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")

func _on_exit_button_pressed():
	get_tree().quit()
