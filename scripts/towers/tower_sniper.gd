class_name TowerSniper extends Tower

const TOWER_SNIPER_SCENE = preload("res://scenes/towers/tower_sniper.tscn")
const SNIPER_SFX = preload("res://assets/sfx/sniper.wav")

static func create_tower_sniper(_damage: float, _range: float, _cooldown: float) -> TowerSniper:
	var new_tower: TowerSniper = TOWER_SNIPER_SCENE.instantiate()
	new_tower.tower_damage = _damage
	new_tower.tower_range = _range
	new_tower.tower_cooldown = _cooldown
	return new_tower

func _ready():
	super._ready()
	sfx.stream = SNIPER_SFX
