extends Node2D
class_name Entity

@onready var world = $"../.."
@onready var health_component = $HealthComponent
@onready var drop_component = $DropComponent

@export var max_health: float = 30
@export var drop_rate: float = 0.30
@export var drop_value: int = 2

func _ready():
	health_component.max_health = max_health
	health_component.current_health = max_health
	health_component.die.connect(die)
	
	drop_component.drop_rate = clamp(drop_rate, 0.0, 1.0)
	drop_component.drop_value = drop_value
	drop_component.world = world

func die():
	drop_component.drop()
	queue_free()
