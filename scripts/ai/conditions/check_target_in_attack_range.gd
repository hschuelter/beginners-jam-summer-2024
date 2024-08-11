extends ConditionLeaf

var fov: Area2D : set = set_fov, get = get_fov
var hitbox: Area2D : set = set_hitbox, get = get_hitbox
var is_target_in_range: bool = false

func tick(actor: Node, _blackboard: Blackboard) -> int:
	if get_hitbox() == null:
		printerr("error: enemy '%s' missing hitbox" % actor.name)
		return FAILURE
		
	var areas: Array[Area2D] = get_hitbox().get_overlapping_areas()
	if areas.is_empty():
		if is_target_in_range:
			is_target_in_range = false
			actor.reset_attack()
			
		return FAILURE

	if not is_target_a_player(areas) and is_player_in_fov():
		return FAILURE

	is_target_in_range = true
	return SUCCESS


func is_target_a_player(areas: Array[Area2D]) -> bool:
	return not areas.filter(func (a): return true if a == Player else false).is_empty()


func is_player_in_fov() -> bool:
	return not get_fov().get_overlapping_areas().filter(func (a): return true if a == Player else false).is_empty()


func set_hitbox(hb: Area2D) -> void:
	hitbox = hb


func get_hitbox() -> Area2D:
	return hitbox


func set_fov(f: Area2D) -> void:
	fov = f


func get_fov() -> Area2D:
	return fov
