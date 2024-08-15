class_name HammerTool extends Tool

@export var damage = 10

func action() -> void:
	if can_action:
		tool_sprite.play("shoot")
		can_action = false
		var target = get_global_mouse_position() - self.global_position
		
		await get_tree().create_timer(0.4).timeout
		
		var melee: Melee = Melee.create_melee(damage, 1, "Melee")
		world.add_child(melee)
		melee.global_position = self.global_position + (target.normalized() * 20)
		action_timer.start()
		

