class_name Tool extends Node2D

@onready var action_timer = $ActionTimer
@export var action_cooldown: float = 0.5
@onready var tool_sprite = $ToolSprite

var world
var can_action: bool = false

func _ready():
	action_timer.wait_time = action_cooldown
	action_timer.start()

func _process(delta):
	var mouse_position = get_global_mouse_position() - self.global_position
	var angle = mouse_position.angle() * 180 / PI
	if angle > 90 or angle < -90:
		self.scale.y = -1
	else:
		self.scale.y = 1
	self.rotation_degrees = angle

func action():
	pass

func _on_timer_timeout():
	can_action = true
