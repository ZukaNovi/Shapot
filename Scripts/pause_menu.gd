extends Control

@onready var main = $"../../"
@onready var v_box_container2 = $VBoxContainer2
@onready var color_rect_2 = $ColorRect2
@onready var v_box_container = $MarginContainer/VBoxContainer
@onready var color_rect = $ColorRect


func _on_return_button_pressed():
	print(main)
	main.pauseMenu()


func _on_options_button_pressed():
	v_box_container2.show()
	v_box_container.hide()
	color_rect.hide()
	color_rect_2.show()
	


func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
