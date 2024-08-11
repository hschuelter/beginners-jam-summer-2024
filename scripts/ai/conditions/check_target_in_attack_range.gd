extends ConditionLeaf

var is_target_in_range: bool = false

func tick(actor: Node, _blackboard: Blackboard) -> int:
	if not actor.has_method("is_target_in_attack_range"):
		printerr("error: enemy '%s' should implement is_target_in_attack_range" % actor.name)
		return FAILURE

	if not actor.is_target_in_attack_range():
		return FAILURE

	if not actor.has_method("is_target_a_player"):
		printerr("error: enemy '%s' should implement is_target_a_player" % actor.name)
		return FAILURE

	if not actor.has_method("is_player_in_fov"):
		printerr("error: enemy '%s' should implement is_player_in_fov" % actor.name)
		return FAILURE

	if not actor.is_target_a_player() and actor.is_player_in_fov():
		print("has target in attack range but it can see the player")
		return FAILURE

	is_target_in_range = true
	return SUCCESS
