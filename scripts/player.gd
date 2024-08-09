extends CharacterBody2D

const SPEED = 250.0

func _physics_process(delta):
	var input_vector = get_input_vector()
	
	handle_movement(input_vector, delta)

func get_input_vector() -> Vector2:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_axis("ui_left", "ui_right")
	input_vector.y = Input.get_axis("ui_up", "ui_down")
	return input_vector

func handle_movement(input_vector: Vector2, delta: float) -> void:
	if input_vector:
		velocity = input_vector.normalized() * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	

	move_and_slide()
