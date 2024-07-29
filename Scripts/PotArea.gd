extends Area2D

var area_active = false
@onready var player = $"../../Player"

func _input(event):
	if area_active && Input.is_action_just_pressed("left_click"):
		ConfigFileHandler.potitem = true

func _on_body_entered(body):
	if body == player:
		area_active = true
