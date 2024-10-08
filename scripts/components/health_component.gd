class_name HealthComponent extends Node2D

signal die

@onready var background_bar = %BackgroundBar
@onready var health_bar = %HealthBar

var max_health: float : get = _get_max_health, set = _set_max_health
var current_health: float : get = _get_current_health, set = _set_current_health


func damage(dmg: float) -> void:
	current_health -= dmg
	update_health_bar()

func heal(value: float) -> void:
	current_health += value
	update_health_bar()


func update_health_bar() -> void:
	health_bar.scale.x = current_health / max_health

#region Setters and Getters
func _get_max_health() -> float:
	return max_health

func _set_max_health(value: float) -> void:
	if (max_health < value):
		var increase = value - max_health
		max_health = value
		current_health += increase

func _get_current_health() -> float:
	return current_health

func _set_current_health(value: float) -> void:
	current_health = clampf(value, 0.0, max_health)	
	if current_health <= 0:
		die.emit()
#endregion

