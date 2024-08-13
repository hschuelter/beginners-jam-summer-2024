class_name MeleeSlow extends Melee

const MELEE_SLOW_SCENE: Resource = preload("res://scenes/melee/melee_slow.tscn")

static func create_melee_slow(_damage: float, _size: float, _name: String) -> MeleeSlow:
	var new_melee_slow: MeleeSlow = MELEE_SLOW_SCENE.instantiate()
	new_melee_slow.damage = _damage
	new_melee_slow.scale *= _size / 10
	new_melee_slow.name = _name
	
	return new_melee_slow

func _on_area_entered(area):
	if area.is_in_group("enemy"):
		area.health_component.damage(self.damage)
		area.is_slowed = true
		area.slow_timer.start()
