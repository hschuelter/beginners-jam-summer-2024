class_name BuildTool extends Tool

const GRID_SIZE = 32
signal spend_resources(tower_cost: float)

var basic_damage: float
var basic_range: float
var basic_cooldown: float
var basic_price: float

var slow_damage: float
var slow_range: float
var slow_cooldown: float
var slow_value: float
var slow_price: float

var sniper_damage: float
var sniper_range: float
var sniper_cooldown: float
var sniper_price: float

enum Towers { BASIC, SLOW, SNIPER }
var current_tower: Towers = Towers.BASIC

func _ready():
	super._ready()
	
	basic_damage = UpgradeManager.basic_damage
	basic_range = UpgradeManager.basic_range
	basic_cooldown = UpgradeManager.basic_cooldown
	basic_price = UpgradeManager.basic_price

	slow_damage = UpgradeManager.slow_damage
	slow_range = UpgradeManager.slow_range
	slow_cooldown = UpgradeManager.slow_cooldown
	slow_value = UpgradeManager.slow_value
	slow_price = UpgradeManager.slow_price

	sniper_damage = UpgradeManager.sniper_damage
	sniper_range = UpgradeManager.sniper_range
	sniper_cooldown = UpgradeManager.sniper_cooldown
	sniper_price = UpgradeManager.sniper_price

func action() -> void:
	if can_action:
		var tower: Tower
		var cost: float
		update_values()
		if current_tower == Towers.BASIC:
			tower = TowerBasic.create_tower_basic(basic_damage, basic_range, basic_cooldown)
			cost = basic_price
		elif current_tower == Towers.SLOW:
			tower = TowerSlow.create_tower_slow(slow_damage, slow_range, slow_cooldown, slow_value)
			cost = slow_price
		elif current_tower == Towers.SNIPER:
			tower = TowerSniper.create_tower_sniper(sniper_damage, sniper_range, sniper_cooldown)
			cost = sniper_price
			
		var mouse_position = (get_global_mouse_position() + Vector2(GRID_SIZE/2, GRID_SIZE/2)) / GRID_SIZE
		
		world.add_child(tower)
		spend_resources.emit(cost)
		tower.global_position = Vector2(mouse_position.floor() * GRID_SIZE) 
		
		can_action = false
		action_timer.start()

func update_values():
	basic_damage = UpgradeManager.basic_damage
	slow_value = UpgradeManager.slow_value
	sniper_range = UpgradeManager.sniper_range
