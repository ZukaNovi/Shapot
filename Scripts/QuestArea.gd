extends Area2D

@export var quest: Quest
@onready var quest_area = $"."

func _process(_delta):
	if ConfigFileHandler.load_quest_settings("quest1") == 0:
		if ConfigFileHandler.load_dialog_settings() == 1:
			quest.reached_goal()
func _on_body_entered(body):
	if ConfigFileHandler.load_quest_settings("quest1") == 0:
		if quest.quest_status == quest.QuestStatus.AVAILABLE:
			#start the quest
			quest.start_quest()
		if quest.quest_status == quest.QuestStatus.REACHED_GOAL:
			#finish quest
			ConfigFileHandler.save_quest_settings("quest1",1)
			quest.finish_quest()

