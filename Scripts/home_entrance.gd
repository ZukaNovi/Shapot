extends Area2D

var entered = false
var game = load("res://Scenes/game.tscn")

func _on_body_entered(_body:CharacterBody2D):
	entered = true


func _on_body_exited(_body):
	entered = false

func _physics_process(_delta):
	if entered == true:
		#get_tree().change_scene_to_file("res://Scenes/game.tscn")
		get_tree().change_scene_to_packed(game)
