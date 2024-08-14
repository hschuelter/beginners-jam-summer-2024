class_name Melee extends Area2D

const MELEE_SCENE: Resource = preload("res://scenes/melee/melee.tscn")

var damage: float = 3

static func create_melee(_damage: float, _size: float, _name: String) -> Melee:
	var new_melee: Melee = MELEE_SCENE.instantiate()
	new_melee.damage = _damage
	new_melee.scale *= _size
	new_melee.name = _name
	
	return new_melee

func _on_duration_timer_timeout():
	queue_free()

func _on_body_entered(body):
	if body.is_in_group("entity"):
		body.health_component.damage(self.damage)
