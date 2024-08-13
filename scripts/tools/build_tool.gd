class_name BuildTool extends Tool

const GRID_SIZE = 32

var basic_damage: float = 10
var basic_range: float = 60
var basic_cooldown: float = 1.0

var slow_damage: float = 2
var slow_range: float = 40
var slow_cooldown: float = 1.0

var sniper_damage: float = 4
var sniper_range: float = 160
var sniper_cooldown: float = 2.0

enum Towers { BASIC, SLOW, SNIPER }
var current_tower: Towers = Towers.BASIC

func action() -> void:
	if can_action:
		var tower: Tower
		if current_tower == Towers.BASIC:
			tower = Tower.create_tower(basic_damage, basic_range, basic_cooldown)
		elif current_tower == Towers.SLOW:
			tower = TowerSlow.create_tower_slow(slow_damage, slow_range, slow_cooldown)
		elif current_tower == Towers.SNIPER:
			tower = TowerSniper.create_tower_sniper(sniper_damage, sniper_range, sniper_cooldown)
			
		var mouse_position = (get_global_mouse_position() + Vector2(GRID_SIZE/2, GRID_SIZE/2)) / GRID_SIZE
		
		world.add_child(tower)
		tower.global_position = Vector2(mouse_position.floor() * GRID_SIZE) 
		
		can_action = false
		action_timer.start()
		
