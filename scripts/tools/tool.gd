class_name Tool extends Node2D

@onready var action_timer = $ActionTimer
@export var action_cooldown: float = 0.5

var world
var can_action: bool = false

func _ready():
	world = get_tree().get_root() 

	action_timer.wait_time = action_cooldown
	action_timer.start()

func _process(delta):
	pass

func action():
	pass

func _on_timer_timeout():
	can_action = true
