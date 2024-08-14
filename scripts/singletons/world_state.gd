extends Node

var _current_hour: int: get = get_current_hour
var _current_day: int

func get_current_hour() -> int:
	return _current_hour

func set_current_hour(hour: int, minute: int) -> void:
	_current_hour = (hour * 100) + minute

func set_current_day(day: int) -> void:
	_current_day = day
