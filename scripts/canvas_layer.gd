extends CanvasLayer

@onready var day_night_cycle_ui = $DayNightCycleUI
@onready var resources_ui = $ResourcesUI
@onready var toolbox_ui = $ToolboxUI
@onready var tower_select_ui = $TowerSelectUI
@onready var upgrade_ui = $UpgradeUI

func _ready():
	tower_select_ui.visible = false
	upgrade_ui.visible = false

func set_daytime(day: int, hour: int, minutes: int):
	day_night_cycle_ui.get_node("DayLabel").text = "Day %d" % [day + 1]
	day_night_cycle_ui.get_node("TimeLabel").text = "%02d:%02d" % [hour, minutes]

func set_resources(gears: int) -> void:
	resources_ui.get_node("ResourcesLabel").text = "%d" % [gears]

func set_toolbox(tool: int) -> void:
	toolbox_ui.get_node("GunLabel").get_node("Selected").visible = tool == 0
	toolbox_ui.get_node("TowerLabel").get_node("Selected").visible = tool == 1
	toolbox_ui.get_node("RepairLabel").get_node("Selected").visible = tool == 2
	toolbox_ui.get_node("HammerLabel").get_node("Selected").visible = tool == 3
	
	tower_select_ui.visible = tool == 1

func open_upgrade_ui():
	upgrade_ui.visible = true
	
func close_upgrade_ui():
	upgrade_ui.visible = false

func _on_close_button_pressed():
	upgrade_ui.visible = false
