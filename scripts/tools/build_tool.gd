extends Tool
class_name BuildTool

const GRID_SIZE = 32

func action() -> void:
	var tower := Tower.create_tower()
	var mouse_position = (get_global_mouse_position() + Vector2(GRID_SIZE/2, GRID_SIZE/2)) / GRID_SIZE
	
	world.add_child(tower)
	tower.global_position = Vector2(mouse_position.floor() * GRID_SIZE) 
	tower.name = "Tower"
