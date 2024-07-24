extends CanvasModulate

const NIGHT_COLOR = Color("#091d3a")
const DAY_COLOR = Color("#ffffff")

func _process(delta):
	if get_tree().current_scene.name == "Dungeon":
		print("in dungeon")
		self.color = NIGHT_COLOR
	else:
		self.color = DAY_COLOR
