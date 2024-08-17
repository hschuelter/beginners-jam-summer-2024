extends Node

#region Basic Tower Upgrades
var basic_upgrade = 3.0
var basic_price = 10
var basic_upgrade_price = 50
var basic_level = 1

var basic_damage: float = 5
var basic_range: float = 60
var basic_cooldown: float = 1.0
#endregion

#region Slow Tower Upgrades
var slow_upgrade = 1.2
var slow_price = 20
var slow_upgrade_price = 40
var slow_level = 1

var slow_damage: float = 2
var slow_range: float = 40
var slow_cooldown: float = 1.0
var slow_value: float = 0.5
#endregion

#region Sniper Tower Upgrades
var sniper_upgrade = 25
var sniper_price = 30
var sniper_upgrade_price = 30
var sniper_level = 1
var sniper_damage: float = 20
var sniper_range: float = 160
var sniper_cooldown: float = 3.0
#endregion


func upgrade_basic() -> void:
	basic_damage += basic_upgrade
	basic_level += 1
	basic_upgrade_price *= 3
	for tower in get_tree().get_nodes_in_group("basic_tower"):
		tower.tower_damage = basic_damage

func upgrade_slow() -> void:
	slow_value /= slow_upgrade
	slow_level += 1
	slow_upgrade_price *= 3
	for tower in get_tree().get_nodes_in_group("slow_tower"):
		tower.tower_slow = slow_value

func upgrade_sniper() -> void:
	sniper_range += sniper_upgrade
	sniper_damage += sniper_upgrade
	sniper_level += 1
	sniper_upgrade_price *= 3
	for tower in get_tree().get_nodes_in_group("sniper_tower"):
		tower.tower_range = sniper_range
		tower.tower_damage = sniper_damage
		tower.collision_shape_2d.shape.radius = sniper_range
		tower.range_sprite.scale = Vector2(sniper_range, sniper_range) / 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset_values():
	basic_upgrade = 3.0
	basic_price = 10
	basic_upgrade_price = 50
	basic_level = 1

	basic_damage = 5
	basic_range = 60
	basic_cooldown = 1.0
	#endregion

	#region Slow Tower Upgrades
	slow_upgrade = 1.2
	slow_price = 20
	slow_upgrade_price = 40
	slow_level = 1

	slow_damage = 2
	slow_range = 40
	slow_cooldown = 1.0
	slow_value = 0.5
	#endregion
	#region Sniper Tower Upgrades
	sniper_upgrade = 25
	sniper_price = 30
	sniper_upgrade_price = 30
	sniper_level = 1
	sniper_damage = 20
	sniper_range = 160
	sniper_cooldown = 3.0
