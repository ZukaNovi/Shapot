extends Sprite2D
var scene_name :String

@onready var player = get_node("/root/Village/Player")
@onready var playerExit = get_node("/root/Dungeon/Player")

func _on_area_2d_body_entered(body):
	if scene_name == "Village":
		if body == player:
			get_tree().change_scene_to_file("res://Scenes/dungeon.tscn")
	elif scene_name == "Dungeon":
		if body == playerExit:
			get_tree().change_scene_to_file("res://Scenes/village.tscn")
