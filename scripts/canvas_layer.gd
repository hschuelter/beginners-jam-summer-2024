extends CanvasLayer

@onready var day_label = $DayNightCycleUI/DayLabel
@onready var time_label = $DayNightCycleUI/TimeLabel
@onready var resources_label = $ResourcesUI/ResourcesLabel


func set_daytime(day: int, hour: int, minutes: int):
	day_label.text = "Day %d" % [day + 1]
	time_label.text = "%02d:%02d" % [hour, minutes]

func set_resources(gears: int) -> void:
	resources_label.text = "%d" % [gears]
	
