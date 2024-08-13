class_name TowerSlow extends Tower

const TOWER_SLOW_SCENE = preload("res://scenes/towers/tower_slow.tscn")

var tower_slow: float

static func create_tower_slow(_damage: float, _range: float, _cooldown: float, _slow: float) -> TowerSlow:
	var new_tower: TowerSlow = TOWER_SLOW_SCENE.instantiate()
	new_tower.tower_damage = _damage
	new_tower.tower_range = _range
	new_tower.tower_cooldown = _cooldown
	new_tower.tower_slow = _slow
	return new_tower

func shoot() -> void:
	var melee_slow: MeleeSlow = MeleeSlow.create_melee_slow(tower_damage, tower_range, tower_slow, "Melee Slow")
	world.add_child(melee_slow)
	melee_slow.global_position = self.global_position
	
	shoot_timer.start()
	can_shoot = false
