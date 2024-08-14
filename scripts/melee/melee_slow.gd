class_name MeleeSlow extends Melee

const MELEE_SLOW_SCENE: Resource = preload("res://scenes/melee/melee_slow.tscn")

var slow: float = 0.5

static func create_melee_slow(_damage: float, _size: float, _slow: float, _name: String) -> MeleeSlow:
	var new_melee_slow: MeleeSlow = MELEE_SLOW_SCENE.instantiate()
	new_melee_slow.damage = _damage
	new_melee_slow.slow = _slow
	new_melee_slow.scale *= _size / 10
	new_melee_slow.name = _name
	
	return new_melee_slow

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.health_component.damage(self.damage)
		DamageNumbers.display_number(damage, body.damage_number_origin.global_position)
		body.is_slowed = true
		body.slow_value = slow
		body.slow_timer.start()
