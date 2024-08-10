extends Node2D
class_name DropComponent

@onready var drop_scene: Resource = preload("res://scenes/drop.tscn")

var world
var drop_rate: float
var drop_value: int
var rng = RandomNumberGenerator.new()

func drop():
	if(rng.randf() < drop_rate):
		instantiate_drop()

func instantiate_drop():
	var new_drop: Drop = Drop.create_drop(drop_value)
	world.add_child(new_drop)
	new_drop.name = "Drop"
	new_drop.global_position = self.global_position
