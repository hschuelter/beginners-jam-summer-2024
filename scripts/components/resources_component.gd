extends Node2D
class_name ResourcesComponent

signal update_resources(gears: int)

var gears: float : get = _get_current_health, set = _set_current_health

func collect(value: float) -> void:
	gears += value

func spend(value: float) -> void:
	gears -= value

func can_build(value: float) -> bool:
	return gears >= value

# Setters and Getters =======================
func _get_current_health() -> float:
	return gears

func _set_current_health(value: float) -> void:
	gears = value
	update_resources.emit(gears)

