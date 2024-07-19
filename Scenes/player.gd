extends CharacterBody2D


const SPEED = 100.0

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
		$AnimatedSprite2D.play("Moving Up")
	elif event.is_action_pressed("ui_down"):
		$AnimatedSprite2D.play("Moving Down")
	elif event.is_action_pressed("ui_right"):
		$AnimatedSprite2D.play("Moving Right")
	elif event.is_action_pressed("ui_left"):
		$AnimatedSprite2D.play("Moving Left")
	else: 
		$AnimatedSprite2D.play("Idle")
