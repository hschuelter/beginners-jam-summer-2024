class_name HammerTool extends Tool

@export var damage = 10

const HAMMER = preload("res://assets/sfx/hammer.wav")

func _ready():
	super._ready()
	sfx.stream = HAMMER
	
func action() -> void:
	if can_action:
		can_action = false
		tool_sprite.play("shoot")
		var target = get_global_mouse_position() - self.global_position
		await get_tree().create_timer(0.4).timeout
		
		var melee: Melee = Melee.create_melee(damage, 1, "Melee")
		sfx._play()
		melee.global_position = self.global_position + (target.normalized() * 20)
		world.add_child(melee)
		action_timer.start()
