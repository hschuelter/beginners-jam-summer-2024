class_name RepairTool extends Tool

@export var repair = 10

var wall: Wall

func action() -> void:
	if can_action:
		tool_sprite.play("shoot")
		can_action = false
		var target = get_global_mouse_position() - self.global_position
		
		await get_tree().create_timer(0.4).timeout
		
		var melee_repair: MeleeRepair = MeleeRepair.create_melee_repair(repair, 1, "Melee Repair")
		
		world.add_child(melee_repair)
		melee_repair.global_position = self.global_position + (target.normalized() * 20)
		
		can_action = false
		action_timer.start()
