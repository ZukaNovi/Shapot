extends TextureProgressBar


@onready var player = $"../../Player"

var over_texture_100 = preload("res://Assets/Sprites/Player/Health-Stamina Bar/healthbarfull.png")
var over_texture_66 = preload("res://Assets/Sprites/Player/Health-Stamina Bar/healthbarhurtl.png")
var over_texture_33 = preload("res://Assets/Sprites/Player/Health-Stamina Bar/healthbarinjured.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("damaged", Callable(self, "_on_player_damage_taken"))
	player.connect("killed", Callable(self, "_on_player_died"))
	
	value = player.currentHP
	min_value = 0
	max_value = player.MAX_HP
	
	texture_over = over_texture_100
	
func _on_player_damage_taken(impact):
	value = player.currentHP
	
	if value > 66 && value < 100:
		pass
	elif value > 33 && value < 66:
		texture_over = over_texture_66
	else:
		texture_over = over_texture_33
		
func _on_player_killed():
	value = player.MAX_HP
	
	
	
