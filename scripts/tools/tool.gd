extends Node2D
class_name Tool

@onready var action_timer = $ActionTimer
@export var action_cooldown: float = 0.5

var world
var can_action: bool = true

func _ready():
	action_timer.wait_time = action_cooldown
	action_timer.start()

func _process(delta):
	pass

func action():
	pass

func _on_timer_timeout():
	can_action = true
