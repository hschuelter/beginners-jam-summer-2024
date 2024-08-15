class_name GunTool extends Tool

@export var bullet_damage: float = 6.0
@export var target = Vector2.ZERO
@onready var marker_2d = $Marker2D

func action() -> void:
	if can_action:
		tool_sprite.play("shoot")
		target = get_global_mouse_position() - self.global_position
		var bullet: Bullet = Bullet.create_bullet(bullet_damage, target.normalized(), "Bullet")
		
		world.add_child(bullet)
		bullet.global_position = marker_2d.global_position
		
		can_action = false
		action_timer.start()

