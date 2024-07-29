extends Area2D

@export var quest: Quest
@onready var quest_area_reached_goal = $QuestAreaReachedGoal

func _process(_delta):
	if ConfigFileHandler.load_dialog_settings() == 1:
		quest.reached_goal()
func _on_body_entered(body):
	if quest.quest_status == quest.QuestStatus.AVAILABLE:
		#start the quest
		quest.start_quest()
	if quest.quest_status == quest.QuestStatus.REACHED_GOAL:
		#finish quest
		quest.finish_quest()

