extends Node

var config = ConfigFile.new()
const SETTINGS_FILE_PATH = "user://settings.ini"
var count_scene = 0

var playerHasItem: bool = false

func _ready():
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		config.set_value("video", "fullscreen",false)
		config.set_value("video", "vsync", false)
		
		config.set_value("audio", "master_volume", 0.5)
		
		config.set_value("firstdialog","value",0)
		
		
		config.save(SETTINGS_FILE_PATH)
	else:
		config.load(SETTINGS_FILE_PATH)
		

func save_video_settings(key: String, value):
	config.set_value("video", key, value)
	config.save(SETTINGS_FILE_PATH)
	
func load_video_settings():
	var video_settings = {}
	for key in config.get_section_keys("video"):
		video_settings[key] = config.get_value("video", key)
	return video_settings
	
func save_audio_settings(key: String, value):
	config.set_value("audio", key, value)
	config.save(SETTINGS_FILE_PATH)

func load_audio_settings():
	var audio_settings = {}
	for key in config.get_section_keys("audio"):
		audio_settings[key] = config.get_value("audio", key)
	return audio_settings

func save_dialog_settings(value):
	config.set_value("firstdialog", "value", value)
	config.save(SETTINGS_FILE_PATH)

func load_dialog_settings():
	return config.get_value("firstdialog","value")

func save_quest_settings(value):
	config.set_value("firstquest", "value", value)
	config.save(SETTINGS_FILE_PATH)
func load_quest_settings():
	return config.get_value("firstquest","value")
