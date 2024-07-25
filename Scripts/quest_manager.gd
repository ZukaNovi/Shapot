class_name QuestManager extends Node2D

#ui elements for quest info to show on screen
@onready var QuestBox: CanvasLayer = GameManager.get_node('QuestBox')
@onready var QuestDescription: RichTextLabel = GameManager.get_node('QuestBox').get_node('QuestDescription')

@export_group("Quest Settings")
@export var quest_description: String
@export var reached_goal_text: String

#all quest statuses
enum QuestStatus{
	AVAILABLE,
	STARTED,
	REACHED_GOAL,
	FINISHED,
}

#quest status
@export var quest_status: QuestStatus = QuestStatus.AVAILABLE

