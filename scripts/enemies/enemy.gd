extends Area2D
class_name Enemy

@onready var health_component = $HealthComponent
@onready var damage_number_origin = $DamageNumberOrigin

@export var player: Player
@export var max_health: float = 30

var target = Vector2.ZERO
const SPEED = 30.0

func _ready():
	health_component.max_health = max_health
	health_component.current_health = max_health
	health_component.die.connect(die)

func _process(delta):
	var direction = target - self.global_position
	
	move(direction.normalized(), delta)
	
	if(self.global_position.distance_to(target) < 5):
		queue_free()

func move(direction: Vector2, delta: float) -> void:
	self.global_position += direction * SPEED * delta

func die():
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("bullet"):
		var damage = area.damage
		health_component.damage(area.damage)
		DamageNumbers.display_number(damage, damage_number_origin.global_position)
		area.queue_free()
