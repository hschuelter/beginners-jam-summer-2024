class_name Entity extends StaticBody2D

@onready var world = $".."
@onready var health_component = $HealthComponent
@onready var drop_component = $DropComponent

@export var max_health: float = 30
@export var drop_rate: float = 1
@export var drop_value: int = 5

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
