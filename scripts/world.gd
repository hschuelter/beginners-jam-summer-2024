extends Node2D

@onready var canvas_layer = $CanvasLayer
@onready var canvas_modulate = $CanvasModulate
@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	canvas_layer.visible = true
	canvas_modulate.time_tick.connect(canvas_layer.set_daytime)
	player.update_resources.connect(canvas_layer.set_resources)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
