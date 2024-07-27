extends Sprite2D

func _on_area_2d_body_entered(_body):
	get_parent().quest.reached_goal()
