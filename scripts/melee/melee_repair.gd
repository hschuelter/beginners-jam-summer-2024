class_name MeleeRepair extends Melee

const MELEE_REPAIR_SCENE: Resource = preload("res://scenes/melee/melee_repair.tscn")

static func create_melee_repair(_damage: float, _size: float, _name: String) -> Melee:
	var new_melee_repair: MeleeRepair = MELEE_REPAIR_SCENE.instantiate()
	new_melee_repair.damage = _damage
	new_melee_repair.scale *= _size
	new_melee_repair.name = _name
	
	return new_melee_repair

func _on_area_entered(area):
	if area.is_in_group("building"):
		area.health_component.heal(self.damage)
