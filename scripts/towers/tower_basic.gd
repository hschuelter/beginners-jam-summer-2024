class_name TowerBasic extends Tower

const TOWER_BASIC_SCENE = preload("res://scenes/towers/tower_basic.tscn")

static func create_tower_basic(_damage: float, _range: float, _cooldown: float) -> TowerBasic:
	var new_tower: TowerBasic = TOWER_BASIC_SCENE.instantiate()
	new_tower.tower_damage = _damage
	new_tower.tower_range = _range
	new_tower.tower_cooldown = _cooldown
	return new_tower
