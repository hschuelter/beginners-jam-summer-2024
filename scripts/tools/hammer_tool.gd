class_name HammerTool extends Tool

@export var damage = 10

func action() -> void:
	if can_action:
		var target = get_global_mouse_position() - self.global_position
		var melee: Melee = Melee.create_melee(damage, 1, "Melee")
		
		world.add_child(melee)
		melee.global_position = self.global_position + (target.normalized() * 20)
		
		can_action = false
		action_timer.start()

