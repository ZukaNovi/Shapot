extends CharacterBody2D


signal damaged(by)
signal died()

const SPEED = 200.0
const MAX_HP = 100.0
var currentHP = MAX_HP


func _physics_process(_delta):
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
func _input(event):
	if event.is_action_pressed("ui_up"):
		$AnimatedSprite2D.play("MoveUp")
	elif event.is_action_pressed("ui_down"):
		$AnimatedSprite2D.play("MoveDown")
	elif event.is_action_pressed("ui_right"):
		$AnimatedSprite2D.play("MoveRight")
	elif event.is_action_pressed("ui_left"):
		$AnimatedSprite2D.play("MoveLeft")
	else:
		if event.is_action_released("ui_up"):
			$AnimatedSprite2D.play("Idle(Back)")
		elif event.is_action_released("ui_down"):
			$AnimatedSprite2D.play("Idle(Screen)")
		elif event.is_action_released("ui_right"):
			$AnimatedSprite2D.play("Idle(Right)")
		elif event.is_action_released("ui_left"):
			$AnimatedSprite2D.play("Idle(Left)")

func take_damage(impact):
	var damage = int(impact)
	var previousHP = currentHP
	currentHP -= damage
	currentHP = clamp(currentHP, 0, MAX_HP)
	
	if previousHP != currentHP:
		emit_signal("damaged", damage)
		
	if currentHP <= 0:
		emit_signal("died")
		get_tree().reload_current_scene()
