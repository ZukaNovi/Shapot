extends Sprite2D

@export var quest :Quest
@onready var bed_sample = $BedSample


func _on_area_2d_body_entered(body):
	if quest.quest_status == quest.QuestStatus.AVAILABLE:
		quest.start_quest() # start the quest
	if quest.quest_status == quest.QuestStatus.REACHED_GOAL:
		quest.finish_quest() # finish quest
