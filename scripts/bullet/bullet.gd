extends Area2D
class_name Bullet

const BULLET_SCENE: Resource = preload("res://scenes/bullet/bullet.tscn")
const SPEED: float = 300

var damage: float = 3
var target: Vector2

static func create_bullet(_damage: float, _target, _name: String) -> Bullet:
	var new_bullet: Bullet = BULLET_SCENE.instantiate()
	new_bullet.damage = _damage
	new_bullet.target = _target
	new_bullet.name = _name
	
	return new_bullet

func _process(delta):
	move(target.normalized(), delta)

func move(direction: Vector2, delta: float) -> void:
	self.global_position += direction * SPEED * delta
