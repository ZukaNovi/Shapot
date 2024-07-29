extends TextureRect

@onready var player = $"../../Player"
@onready var explosion_potion = $ExplosionPotion
@onready var acid_potion = $AcidPotion
@onready var teleport_potion = $TeleportPotion
@onready var explosion_cooldown = $ExplosionPotion/ExplosionCooldown
@onready var acid_cooldown = $AcidPotion/AcidCooldown
@onready var teleport_cooldown = $TeleportPotion/TeleportCooldown

var ORIGINAL_HUD = preload("res://Assets/Sprites/Hud/Hud_original.png")
var ORANGE_HUD = preload("res://Assets/Sprites/Hud/Hud_orange.png")
var RED_HUD = preload("res://Assets/Sprites/Hud/Hud_red.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	texture = ORIGINAL_HUD
	
	set_initial_values()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player.currentPotion == player.EXPLOSION:
		explosion_potion.play("Idle")
	elif player.currentPotion == player.ACID:
		acid_potion.play("Idle")
	elif player.currentPotion == player.TELEPORT:
		teleport_potion.play("Idle")
		
	update_cooldowns()

func set_initial_values():
	explosion_cooldown.max_value = 100
	acid_cooldown.max_value = 100
	teleport_cooldown.max_value = 100

func update_cooldowns():
	explosion_cooldown.value = calculate_cooldown_percentage(player.EXPLOSION)
	acid_cooldown.value = calculate_cooldown_percentage(player.ACID)
	teleport_cooldown.value = calculate_cooldown_percentage(player.TELEPORT)

func calculate_cooldown_percentage(potion_type):
	var current_time = Time.get_ticks_msec() / 1000.0
	var last_use_time = player.lastPotionUseTimes[potion_type]
	var cooldown = player.potionCooldowns[potion_type]
	var elapsed_time = current_time - last_use_time
	var percentage = (elapsed_time / cooldown) * 100.0
	return clamp(percentage, 0, 100)
		
