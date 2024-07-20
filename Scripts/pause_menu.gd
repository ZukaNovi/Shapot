extends Control

@onready var main = $"../../"
@onready var v_box_container = $VBoxContainer
@onready var color_rect_2 = $ColorRect2



func _on_return_button_pressed():
	main.pauseMenu()


func _on_options_button_pressed():
	v_box_container.show()
	color_rect_2.show()


func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
