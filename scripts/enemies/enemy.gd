extends Area2D
class_name Enemy


@export var player: Player

var target = Vector2.ZERO
const SPEED = 30.0

func _ready():
	pass

func _process(delta):
	var direction = target - self.global_position
	
	move(direction.normalized(), delta)
	
	# 
	if(self.global_position.distance_to(target) < 5):
		queue_free()

func move(direction: Vector2, delta: float) -> void:
	self.global_position += direction * SPEED * delta
