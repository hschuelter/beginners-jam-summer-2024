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
		
	#var dist: Array[Distance]
	#for tg in get_static_targets():
		#dist.append(
			#_init_distance(
				#tg.global_position, 
				#actor.global_position.distance_to(tg.global_position)
			#)
		#)
	#
	#dist.sort_custom(func(a, b): return true if a.distance < b.distance else false)
	#actor.set_target_position(actor.global_position)
	actor.set_target_position(Vector2.ZERO)

	return SUCCESS


func set_static_targets(targets: Array[Node]) -> void:
	static_targets = targets
	
	
func get_static_targets() -> Array[Node]:
	return static_targets
