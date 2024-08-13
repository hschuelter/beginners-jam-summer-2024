class_name BuildTool extends Tool

const GRID_SIZE = 32

var basic_damage: float
var basic_range: float
var basic_cooldown: float

var slow_damage: float
var slow_range: float
var slow_cooldown: float
var slow_value: float

var sniper_damage: float
var sniper_range: float
var sniper_cooldown: float

enum Towers { BASIC, SLOW, SNIPER }
var current_tower: Towers = Towers.BASIC

func _ready():
	super._ready()
	
	basic_damage = UpgradeManager.basic_damage
	basic_range = UpgradeManager.basic_range
	basic_cooldown = UpgradeManager.basic_cooldown

	slow_damage = UpgradeManager.slow_damage
	slow_range = UpgradeManager.slow_range
	slow_cooldown = UpgradeManager.slow_cooldown
	slow_value = UpgradeManager.slow_value

	sniper_damage = UpgradeManager.sniper_damage
	sniper_range = UpgradeManager.sniper_range
	sniper_cooldown = UpgradeManager.sniper_cooldown

func action() -> void:
	if can_action:
		var tower: Tower
		update_values()
		if current_tower == Towers.BASIC:
			tower = TowerBasic.create_tower_basic(basic_damage, basic_range, basic_cooldown)
		elif current_tower == Towers.SLOW:
			tower = TowerSlow.create_tower_slow(slow_damage, slow_range, slow_cooldown, slow_value)
		elif current_tower == Towers.SNIPER:
			tower = TowerSniper.create_tower_sniper(sniper_damage, sniper_range, sniper_cooldown)
			
		var mouse_position = (get_global_mouse_position() + Vector2(GRID_SIZE/2, GRID_SIZE/2)) / GRID_SIZE
		
		world.add_child(tower)
		tower.global_position = Vector2(mouse_position.floor() * GRID_SIZE) 
		
		can_action = false
		action_timer.start()

func update_values():
	basic_damage = UpgradeManager.basic_damage
	slow_value = UpgradeManager.slow_value
	sniper_range = UpgradeManager.sniper_range
