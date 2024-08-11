extends ActionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	var target_position = _blackboard.get_value("target_position") as Vector2
	if not actor.has_method("set_target_position"):
		return FAILURE
		
	actor.set_target_position(target_position)
	return SUCCESS
