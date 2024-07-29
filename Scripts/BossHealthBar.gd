extends TextureProgressBar

@onready var boss = $"../../Boss"


# Called when the node enters the scene tree for the first time.
func _ready():
	boss.connect("damaged", Callable(self, "_on_boss_damage_taken"))
	boss.connect("died", Callable(self, "_on_boss_died"))
	
	value = boss.MAX_HP
	min_value = 0
	max_value = boss.MAX_HP

func _on_boss_damage_taken(_impact):
	value = boss.currentHP

func _on_boss_killed():
	value = boss.MAX_HP
	
