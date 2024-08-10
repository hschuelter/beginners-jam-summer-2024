extends Area2D
class_name Drop

const DROP_SCENE: Resource = preload("res://scenes/drop.tscn")

var gears: int = 2

static func create_drop(_gears: int, _name: String = "") -> Drop:
	var new_drop: Drop = DROP_SCENE.instantiate()
	new_drop.gears = _gears
	new_drop.name = _name
	
	return new_drop

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
