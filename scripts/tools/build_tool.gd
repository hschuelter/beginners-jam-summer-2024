class_name BuildTool extends Tool

const GRID_SIZE = 32

var basic_tower_damage: float = 10
var slow_tower_damage: float = 2

enum Towers { BASIC, SLOW}
var current_tower: Towers = Towers.BASIC

func action() -> void:
	if can_action:
		var tower: Tower
		if current_tower == Towers.BASIC:
			tower = Tower.create_tower(basic_tower_damage)
		elif current_tower == Towers.SLOW:
			tower = TowerSlow.create_tower_slow(slow_tower_damage)
			
		var mouse_position = (get_global_mouse_position() + Vector2(GRID_SIZE/2, GRID_SIZE/2)) / GRID_SIZE
		
		world.add_child(tower)
		tower.global_position = Vector2(mouse_position.floor() * GRID_SIZE) 
		
		can_action = false
		action_timer.start()
		
