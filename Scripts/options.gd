extends Control

@onready var fullscreen_checkbox = $Fullscreen
@onready var vsync_checkbox = $VSync
@onready var volume_slider = $VolumeSlider
@onready var v_box_container = $"."
@onready var color_rect_2 = $"../ColorRect2"


# Called when the node enters the scene tree for the first time.
func _ready():
	var video_settings = ConfigFileHandler.load_video_settings()
	fullscreen_checkbox.button_pressed = video_settings.fullscreen
	vsync_checkbox.button_pressed = video_settings.vsync
	
	var audio_settings = ConfigFileHandler.load_audio_settings()
	volume_slider.value = min(audio_settings.master_volume, 1.0) * 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_fullscreen_toggled(toggled_on):
	ConfigFileHandler.save_video_settings("fullscreen", toggled_on)
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_back_pressed():
	v_box_container.hide()
	color_rect_2.hide()

func _on_v_sync_toggled(toggled_on):
	ConfigFileHandler.save_video_settings("vsync", toggled_on)
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)


func _on_volume_slider_drag_ended(value_changed):
	if value_changed:
		ConfigFileHandler.save_audio_settings("master_volume", volume_slider.value / 100)
