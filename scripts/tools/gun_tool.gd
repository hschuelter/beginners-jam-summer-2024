extends Tool
class_name GunTool

@onready var shoot_timer = $ShootTimer

@export var bullet_damage = 1
@export var target = Vector2.ZERO

var can_shoot: bool = false

func action() -> void:
	target = get_global_mouse_position() - self.global_position
	var bullet: Bullet = Bullet.create_bullet(bullet_damage, target.normalized(), "Bullet")
	
	world.add_child(bullet)
	bullet.global_position = self.global_position
	#shoot_timer.start()
	#can_shoot = false
