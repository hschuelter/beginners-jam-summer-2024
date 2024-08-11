extends ActionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	if not actor.has_method("attack"):
		printerr("error: enemy '%s' sshould implement attack() method" % actor.name)
		return FAILURE
		
	actor.attack()
	return SUCCESS
