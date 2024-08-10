extends Area2D
class_name Bullet

const SPEED: float = 300

var target: Enemy
var target_position
var damage: float = 3


func _process(delta):
	if target != null:
		target_position = target.global_position
		var direction = target_position - self.global_position
		
		move(direction.normalized(), delta)
	else:
		queue_free()

func move(direction: Vector2, delta: float) -> void:
	self.global_position += direction * SPEED * delta
