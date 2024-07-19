extends Control

@onready var main = $"../../"

func _on_return_button_pressed():
	main.pauseMenu()


func _on_options_button_pressed():
	pass 


func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
