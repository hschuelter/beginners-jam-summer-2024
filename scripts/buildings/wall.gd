extends Area2D
class_name Wall

@onready var health_component = $HealthComponent
@onready var damage_number_origin = $DamageNumberOrigin

@export var max_health: float = 100

func _ready():
	health_component.max_health = max_health
	health_component.current_health = max_health
	health_component.die.connect(die)


func _process(delta):
	pass

func die():
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("enemy"):
		var damage: float = area.damage
		area.queue_free()
		DamageNumbers.display_number(damage, damage_number_origin.global_position)
		health_component.damage(damage)
