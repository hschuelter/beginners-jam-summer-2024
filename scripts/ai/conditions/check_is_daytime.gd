extends ConditionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	var current_hour: int = WorldState.get_current_hour()
	if current_hour >= 600 and current_hour <= 1800:
		return SUCCESS
	
	return FAILURE
