extends ConditionLeaf

var is_target_in_range: bool = false

func tick(actor: Node, _blackboard: Blackboard) -> int:
	if not actor.has_method("target_in_attack_range"):
		printerr("error: enemy '%s' should implement is_target_in_attack_range" % actor.name)
		return FAILURE

	var targets = actor.target_in_attack_range()
	if targets.is_empty():
		return FAILURE

	if not actor.has_method("is_target_a_player"):
		printerr("error: enemy '%s' should implement is_target_a_player" % actor.name)
		return FAILURE

	if not actor.has_method("is_player_in_fov"):
		printerr("error: enemy '%s' should implement is_player_in_fov" % actor.name)
		return FAILURE

	var target: Node = targets[0]
	if not actor.is_target_a_player() and actor.is_player_in_fov():
		return FAILURE

	_blackboard.set_value("attack_target", target)
	is_target_in_range = true
	return SUCCESS
