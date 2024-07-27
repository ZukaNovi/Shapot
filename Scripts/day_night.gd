extends CanvasModulate

const NIGHT_COLOR = Color("#091d3a")
const DAY_COLOR = Color("#ffffff")
@onready var day_night_cycle = $".."


func _process(_delta):
	if day_night_cycle.scene_name == "Game":
		self.color = NIGHT_COLOR
	else:
		self.color = DAY_COLOR
