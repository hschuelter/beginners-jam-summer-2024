extends Node2D

@onready var canvas_layer = $CanvasLayer
@onready var day_night_cycle = $DayNightCycle
@onready var player = $Player
@onready var wave_spawner = $WaveSpawner
@onready var walls = $Walls
@onready var table = $Table

func _ready():
	canvas_layer.visible = true
	day_night_cycle.time_tick.connect(canvas_layer.set_daytime)
	day_night_cycle.change_daytime.connect(wave_spawner.change_daytime)
	
	player.resources_component.update_resources.connect(canvas_layer.set_resources)
	player.update_toolbox.connect(canvas_layer.set_toolbox)
	
	table.open_upgrade_ui.connect(canvas_layer.open_upgrade_ui)
	table.close_upgrade_ui.connect(canvas_layer.close_upgrade_ui)


func _process(delta):
	pass

func _on_basic_button_pressed():
	player.current_tower = 0

func _on_slow_button_pressed():
	player.current_tower = 1

func _on_sniper_button_pressed():
	player.current_tower = 2

func _on_mouse_entered_ui():
	player.mouse_on_field = false

func _on_mouse_exited_ui():
	player.mouse_on_field = true

func _on_basic_upgrade_pressed():
	UpgradeManager.upgrade_basic()

func _on_slow_upgrade_pressed():
	UpgradeManager.upgrade_slow()

func _on_sniper_upgrade_pressed():
	UpgradeManager.upgrade_sniper()
