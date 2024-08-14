extends ActionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	if not actor.has_method("attack"):
		printerr("error: enemy '%s' sshould implement attack() method" % actor.name)
		return FAILURE
		
	var target = _blackboard.get_value("attack_target")
	if target.get_parent() is Player:
		target = target.get_parent()

	actor.attack(target)
	return SUCCESS
