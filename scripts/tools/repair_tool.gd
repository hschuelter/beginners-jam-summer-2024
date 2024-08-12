extends Tool
class_name RepairTool

@export var repair = 10

var wall: Wall

func action() -> void:
	if can_action:
		var target = get_global_mouse_position() - self.global_position
		var melee_repair: MeleeRepair = MeleeRepair.create_melee_repair(repair, "Melee Repair")
		
		world.add_child(melee_repair)
		melee_repair.global_position = self.global_position + (target.normalized() * 20)
		
		can_action = false
