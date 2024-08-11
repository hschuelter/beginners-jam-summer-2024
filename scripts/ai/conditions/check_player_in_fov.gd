extends ConditionLeaf


var fov: Area2D : set = set_fov, get = get_fov
var is_player_in_fov: bool = false


func tick(actor: Node, _blackboard: Blackboard) -> int:
	if get_fov() == null:
		printerr("error: enemy %s fov not set" % actor.name)
		return FAILURE

	var areas: Array[Area2D] = (get_fov()
		.get_overlapping_areas()
		.filter(func (a): return true if a == Player else false)
	)
	if areas.is_empty():
		reset(actor, _blackboard)
		return FAILURE

	var hurtbox = areas[0]
	_blackboard.set_value("target_position", hurtbox.global_position)
	is_player_in_fov = true

	return SUCCESS


func reset(actor: Node, _blackboard: Blackboard) -> void:
	_blackboard.erase_value("target_position")
	if is_player_in_fov:
		is_player_in_fov = false
		actor.flip_h(0)


func set_fov(area: Area2D) -> void:
	fov = area


func get_fov() -> Area2D:
	return fov
