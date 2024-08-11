extends ConditionLeaf

var is_player_in_fov: bool = false


func tick(actor: Node, _blackboard: Blackboard) -> int:
	if not actor.has_method("is_player_in_fov"):
		printerr("error: enemy %s should implement is_player_in_fov" % actor.name)
		return FAILURE
		
	if not actor.is_player_in_fov():
		reset(actor, _blackboard)
		return FAILURE
	
	if not actor.has_method("get_player_position"):
		printerr("error: enemy %s should implement get_player_position" % actor.name)
		return FAILURE

	var target_position = actor.get_player_position()
	_blackboard.set_value("target_position", target_position)
	is_player_in_fov = true

	return SUCCESS


func reset(actor: Node, _blackboard: Blackboard) -> void:
	_blackboard.erase_value("target_position")
	if is_player_in_fov:
		is_player_in_fov = false
		#actor.flip_h(0)
