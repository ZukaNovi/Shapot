class_name Quest extends QuestManager

#start the quest
func start_quest() -> void:
	#make sure this quest is available to start
	if quest_status == QuestStatus.AVAILABLE:
		#update quest status
		quest_status = QuestStatus.STARTED
		#update ui
		QuestBox.visible = true
		QuestDescription.text = quest_description

#mark goal as reached
func reached_goal() -> void:
	if quest_status == QuestStatus.STARTED:
		#update quest status
		quest_status = QuestStatus.REACHED_GOAL
		#update ui
		QuestDescription.text = reached_goal_text

#finish the quest
func finish_quest() -> void:
	if quest_status == QuestStatus.REACHED_GOAL:
		#update quest status
		quest_status = QuestStatus.FINISHED
		#update ui
		QuestBox.visible = false
