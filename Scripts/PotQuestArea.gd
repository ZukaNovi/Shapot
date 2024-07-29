extends Area2D
@onready var player = $"../Player"
@export var quest: Quest
@onready var shapot = $"../Shapot"
@onready var pot = $"../Pot"
@onready var animation_player = $"../Shapot/AnimationPlayer"


func _process(delta):
	if ConfigFileHandler.potitem:
		quest.reached_goal()
	if quest.quest_status == quest.QuestStatus.REACHED_GOAL:
		pot.hide()
		shapot.show()
		animation_player.play("Shapooooot")
		quest.finish_quest()
		if quest.quest_status == quest.QuestStatus.FINISHED:
			await get_tree().create_timer(4).timeout
			get_tree().change_scene_to_file("res://Scenes/prologue.tscn")
		
		

func _on_body_entered(body):
	if body == player:
		if ConfigFileHandler.playerHasItem:
			if ConfigFileHandler.load_quest_settings("quest4") == 0:
				if quest.quest_status == quest.QuestStatus.AVAILABLE:
					#start the quest
					quest.start_quest()
				if quest.quest_status == quest.QuestStatus.REACHED_GOAL:
					#finish quest
					ConfigFileHandler.save_quest_settings("quest4",1)
					quest.finish_quest()
					
	
