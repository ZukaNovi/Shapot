extends Area2D

@export var text_key: String = ""
@onready var dialog_area_bed_first = $"."
@onready var dialog_area_go_bed = $"../DialogAreaGoBed"

var area_active: bool = false
func _input(event):
	if area_active and event.is_action_pressed("left_click"):
		SignalBus.emit_signal("display_dialog", text_key)
		
func _on_DialogArea_area_entered(_area):
	print(ConfigFileHandler.load_dialog_settings())
	if ConfigFileHandler.load_dialog_settings() != 1:
		area_active = true


func _on_DialogArea_area_exited(_area):
	area_active = false
	ConfigFileHandler.save_dialog_settings(1)
