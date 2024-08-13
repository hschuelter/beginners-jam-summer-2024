class_name TowerSlow extends Tower

const TOWER_SLOW_SCENE = preload("res://scenes/towers/tower_slow.tscn")

static func create_tower_slow(_damage, _name: String = "Tower Slow") -> TowerSlow:
	var new_tower: TowerSlow = TOWER_SLOW_SCENE.instantiate()
	new_tower.tower_damage = _damage
	new_tower.name = _name
	return new_tower

func shoot() -> void:
	var melee_slow: MeleeSlow = MeleeSlow.create_melee_slow(tower_damage, tower_range / 10, "Melee Slow")
	world.add_child(melee_slow)
	melee_slow.global_position = self.global_position
	
	shoot_timer.start()
	can_shoot = false
