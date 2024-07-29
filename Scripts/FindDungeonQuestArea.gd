extends Area2D

@export var quest: Quest
func _process(_delta):
	if ConfigFileHandler.load_quest_settings("quest2") == 1:
		quest.reached_goal()
	if quest.quest_status == quest.QuestStatus.REACHED_GOAL:
			#finish quest
			#ConfigFileHandler.save_quest_settings("quest2",1)
		quest.finish_quest()
func _on_body_entered(body):
	if ConfigFileHandler.load_quest_settings("quest2") == 0:
		if quest.quest_status == quest.QuestStatus.AVAILABLE:
			#start the quest
			quest.start_quest()
		if quest.quest_status == quest.QuestStatus.REACHED_GOAL:
			#finish quest
			ConfigFileHandler.save_quest_settings("quest2",1)
			quest.finish_quest()
