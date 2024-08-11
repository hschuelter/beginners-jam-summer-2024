extends Tool
class_name GunTool

@onready var shoot_timer = $ShootTimer

@export var bullet_damage: float = 1.0
@export var shot_cooldown: float = 0.5
@export var target = Vector2.ZERO

var can_shoot: bool = true

func _ready():
	shoot_timer.wait_time = shot_cooldown
	shoot_timer.start()


func action() -> void:
	if can_shoot:
		can_shoot = false
		
		target = get_global_mouse_position() - self.global_position
		var bullet: Bullet = Bullet.create_bullet(bullet_damage, target.normalized(), "Bullet")
		
		world.add_child(bullet)
		bullet.global_position = self.global_position


func _on_shoot_timer_timeout():
	can_shoot = true
