extends Area2D
class_name Melee

const MELEE_SCENE: Resource = preload("res://scenes/melee/melee.tscn")

var damage: float = 3

static func create_melee(_damage: float, _name: String) -> Melee:
	var new_melee: Melee = MELEE_SCENE.instantiate()
	new_melee.damage = _damage
	new_melee.name = _name
	
	return new_melee

func _on_area_entered(area):
	if area.is_in_group("entity"):
		area.health_component.damage(self.damage)

func _on_duration_timer_timeout():
	queue_free()
