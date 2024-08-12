extends Tool
class_name GunTool

@export var bullet_damage: float = 1.0
@export var target = Vector2.ZERO

func action() -> void:
	if can_action:
		target = get_global_mouse_position() - self.global_position
		var bullet: Bullet = Bullet.create_bullet(bullet_damage, target.normalized(), "Bullet")
		
		world.add_child(bullet)
		bullet.global_position = self.global_position
		
		can_action = false
