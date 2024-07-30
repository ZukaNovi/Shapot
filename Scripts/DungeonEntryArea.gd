extends Area2D


func _on_body_entered(body):
	print("bum")
	ConfigFileHandler.save_quest_settings("quest2",1)
	ConfigFileHandler.quest2done = true
	print(ConfigFileHandler.load_quest_settings("quest2"))
