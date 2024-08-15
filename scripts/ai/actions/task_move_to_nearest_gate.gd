extends ActionLeaf

var static_targets: Array[Node] : set = set_static_targets, get = get_static_targets

class Distance:
	var position: Vector2
	var distance: float
	
func _init_distance(position: Vector2, distance: float) -> Distance:
	var n = Distance.new()
	n.distance = distance
	n.position = position
	return n


func tick(actor: Node, _blackboard: Blackboard) -> int:
	if not actor.has_method("set_target_position"):
		printerr("error: %s must implement set_target_position(Vector2) method" % actor.name)
		return FAILURE
		
	if !actor.is_static:
		actor.set_target_position(Vector2.ZERO)

	return SUCCESS


func set_static_targets(targets: Array[Node]) -> void:
	static_targets = targets
	
	
func get_static_targets() -> Array[Node]:
	return static_targets
