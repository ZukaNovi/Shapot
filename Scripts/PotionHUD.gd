extends TextureRect

@onready var player = $"../../Player"
@onready var explosion_potion = $ExplosionPotion
@onready var acid_potion = $AcidPotion
@onready var teleport_potion = $TeleportPotion

var ORIGINAL_HUD = preload("res://Assets/Sprites/Hud/Hud_original.png")
var ORANGE_HUD = preload("res://Assets/Sprites/Hud/Hud_orange.png")
var RED_HUD = preload("res://Assets/Sprites/Hud/Hud_red.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	texture = ORIGINAL_HUD
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.currentPotion == player.EXPLOSION:
		explosion_potion.play("Idle")
	elif player.currentPotion == player.ACID:
		acid_potion.play("Idle")
	elif player.currentPotion == player.TELEPORT:
		teleport_potion.play("Idle")
		
