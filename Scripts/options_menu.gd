extends Control
#var red = preload("res://Assets/Sprites/Hud/Hud_red.png")
#var orange = preload("res://Assets/Sprites/Hud/Hud_orange.png")
#var original = preload("res://Assets/Sprites/Hud/Hud_original.png")
#var DUNGEON_SCENE = preload("res://Scenes/dungeon.tscn")
#@onready var potion_hud = get_node("Dungeon/CanvasLayer/PotionHUD")

#BU RENK SECME OLAYI OLCAK

@onready var fullscreen_checkbox = $VBoxContainer/Fullscreen
@onready var vsync_checkbox = $VBoxContainer/VSync
@onready var volume_slider = $VBoxContainer/VolumeSlider
# Called when the node enters the scene tree for the first time.
func _ready():
	var video_settings = ConfigFileHandler.load_video_settings()
	fullscreen_checkbox.button_pressed = video_settings.fullscreen
	vsync_checkbox.button_pressed = video_settings.vsync
	
	var audio_settings = ConfigFileHandler.load_audio_settings()
	volume_slider.value = min(audio_settings.master_volume, 1.0) * 100

func _on_fullscreen_toggled(toggled_on):
	ConfigFileHandler.save_video_settings("fullscreen", toggled_on)
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_backbutton_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_v_sync_toggled(toggled_on):
	ConfigFileHandler.save_video_settings("vsync", toggled_on)
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)


func _on_volume_slider_drag_ended(value_changed):
	if value_changed:
		ConfigFileHandler.save_audio_settings("master_volume", volume_slider.value / 100)


func _on_option_button_item_selected(index):
	#match index:
		#0:
			#potion_hud.texture("original")
		#1:
			#potion_hud.texture("red")
		#2:
			#potion_hud.texture("orange")
	pass
