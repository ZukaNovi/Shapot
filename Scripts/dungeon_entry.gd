extends Sprite2D

func _on_area_2d_body_entered(body):
	print("player entered")
	get_tree().change_scene_to_file("res://Scenes/dungeon.tscn")
