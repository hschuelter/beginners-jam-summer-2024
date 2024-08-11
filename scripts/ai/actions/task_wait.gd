extends ActionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	_blackboard.set_value("target_position", actor.global_position)
	if not actor.has_method("set_target_position"):
		printerr("error: '%s' should implement set_target_position(Vector2) method" % actor.name)
		return FAILURE
		
	actor.set_target_position(actor.global_position)
	return SUCCESS

