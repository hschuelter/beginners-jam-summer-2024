extends Node2D

@onready var canvas_layer = $CanvasLayer
@onready var day_night_cycle = $DayNightCycle
@onready var player = $Player
@onready var wave_spawner = $WaveSpawner
@onready var walls = $Walls

func _ready():
	canvas_layer.visible = true
	day_night_cycle.time_tick.connect(canvas_layer.set_daytime)
	day_night_cycle.change_daytime.connect(wave_spawner.change_daytime)
	
	player.resources_component.update_resources.connect(canvas_layer.set_resources)
	player.update_toolbox.connect(canvas_layer.set_toolbox)
	
	for wall in walls.get_children():
		wall.wall_selected.connect(player.set_wall)
		wall.player = player
	

func _process(delta):
	pass
