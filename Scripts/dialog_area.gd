extends Area2D

@export var text_key: String = ""

var area_active: bool = false

func _physics_process(_delta):
	if area_active:
		SignalBus.emit_signal("display_dialog", text_key)
	#if ConfigFileHandler.load_dialog_settings() == 1:
		#queue_free()


func _on_DialogArea_area_entered(area):
	print(ConfigFileHandler.load_dialog_settings())
	if ConfigFileHandler.load_dialog_settings() != 1:
		area_active = true


func _on_DialogArea_area_exited(area):
	area_active = false
	ConfigFileHandler.save_dialog_settings(1)
