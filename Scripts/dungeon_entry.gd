extends Sprite2D
var scene_name :String

func _on_area_2d_body_entered(body):
	print("player entered")
	if scene_name == "Game":
		get_tree().change_scene_to_file("res://Scenes/dungeon.tscn")
	elif scene_name == "Dungeon":
		get_tree().change_scene_to_file("res://Scenes/game.tscn")
