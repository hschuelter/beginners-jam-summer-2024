class_name GunTool extends Tool

@export var bullet_damage: float = 6.0
@export var target = Vector2.ZERO
@onready var marker_2d = $Marker2D

var bullet_timer: Timer

const SHOOT = preload("res://assets/sfx/shoot.wav")


func _ready():
	super._ready()
	sfx.stream = SHOOT
	bullet_timer = Timer.new()
	bullet_timer.wait_time = 0.135
	bullet_timer.timeout.connect(_on_bullet_timer_timeout)
	add_child(bullet_timer)

func action() -> void:
	if can_action:
		tool_sprite.play("shoot")
		target = get_global_mouse_position() - self.global_position
		var bullet: Bullet = Bullet.create_bullet(bullet_damage, target.normalized(), "Bullet")

		world.add_child(bullet)
		bullet_timer.start()
		sfx._play()
		bullet.global_position = marker_2d.global_position
		
		can_action = false
		action_timer.start()


func _on_bullet_timer_timeout() -> void:
	var bullet = world.get_node("Bullet")
	if bullet:
		bullet.queue_free()
