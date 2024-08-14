extends Node2D

@onready var audio_player = $AudioPlayer
@onready var canvas_layer = $CanvasLayer
@onready var day_night_cycle = $DayNightCycle
@onready var player = $Player
@onready var wave_spawner = $WaveSpawner
@onready var walls = $Walls
@onready var table = $Table
@onready var danger_zone = $DangerZone


func _ready():
	canvas_layer.visible = true
	day_night_cycle.time_tick.connect(canvas_layer.set_daytime)
	day_night_cycle.change_daytime.connect(wave_spawner.change_daytime)
	day_night_cycle.play_day_music.connect(audio_player.play_day)
	day_night_cycle.play_night_music.connect(audio_player.play_night)
	
	player.resources_component.update_resources.connect(canvas_layer.set_resources)
	player.update_toolbox.connect(canvas_layer.set_toolbox)
	
	table.open_upgrade_ui.connect(canvas_layer.open_upgrade_ui)
	table.close_upgrade_ui.connect(canvas_layer.close_upgrade_ui)
	
	wave_spawner.update_danger_zone.connect(danger_zone.update_danger_zone)
	
	audio_player.play_day()
	

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
	if player.resources_component.can_build(UpgradeManager.basic_price):
		player.resources_component.spend(UpgradeManager.basic_price)
		UpgradeManager.upgrade_basic()

func _on_slow_upgrade_pressed():
	if player.resources_component.can_build(UpgradeManager.slow_price):
		player.resources_component.spend(UpgradeManager.slow_price)
		UpgradeManager.upgrade_slow()

func _on_sniper_upgrade_pressed():
	if player.resources_component.can_build(UpgradeManager.sniper_price):
		player.resources_component.spend(UpgradeManager.sniper_price)
		UpgradeManager.upgrade_sniper()
