extends CanvasModulate

const NIGHT_COLOR = Color("#091d3a")
const DAY_COLOR = Color("#ffffff")
var sceneName :String

func _process(delta):
	if sceneName == "Dungeon":
		self.color = NIGHT_COLOR
	else:
		self.color = DAY_COLOR
