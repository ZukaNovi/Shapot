extends Area2D

@export var quest: Quest
func _process(delta):
	if ConfigFileHandler.playerHasItem:
		quest.reached_goal()
func _on_body_entered(body):
	if ConfigFileHandler.load_quest_settings("quest3") == 0:
		if quest.quest_status == quest.QuestStatus.AVAILABLE:
			#start the quest
			quest.start_quest()
		if quest.quest_status == quest.QuestStatus.REACHED_GOAL:
			#finish quest
			ConfigFileHandler.save_quest_settings("quest3",1)
			quest.finish_quest()
