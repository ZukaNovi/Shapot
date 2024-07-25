extends Sprite2D

@export var quest :Quest

func _on_area_2d_body_entered(_body):
	quest.reached_goal()
	queue_free()
