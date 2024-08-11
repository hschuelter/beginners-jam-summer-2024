extends Area2D
class_name Enemy

@onready var health_component = $HealthComponent
@onready var damage_number_origin = $DamageNumberOrigin
@onready var fov: Area2D = $FOV
@onready var hitbox: Area2D = $Hitbox 

@export var player: Player
@export var max_health: float = 30
@export var gates: Array[Node]

var target = Vector2.ZERO
const SPEED = 30.0

func _ready():
	health_component.max_health = max_health
	health_component.current_health = max_health
	health_component.die.connect(die)

func _process(delta):
	var direction = target - self.global_position
	
	move(direction.normalized(), delta)
	
	if(self.global_position.distance_to(target) < 5):
		queue_free()

func move(direction: Vector2, delta: float) -> void:
	self.global_position += direction * SPEED * delta

func die():
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("bullet"):
		var damage = area.damage
		health_component.damage(area.damage)
		DamageNumbers.display_number(damage, damage_number_origin.global_position)
		area.queue_free()


func attack() -> void:
	print("attacking")


func set_target_position(pos: Vector2) -> void:
	target = pos


func is_player_in_fov() -> bool:
	return not (fov
		.get_overlapping_areas()
		.filter(func (a): return true if a.get_parent() is Player else false)
		.is_empty()
	)


func get_player_position() -> Vector2:
	return (fov
		.get_overlapping_areas()
		.filter(func (a): return true if a.get_parent() is Player else false)[0]
		.global_position
	)


func is_target_in_attack_range() -> bool:
	return not (hitbox
		.get_overlapping_areas()
		.filter(func (a): return true if a.get_parent() is Player else false)
		.is_empty()
	)


func is_target_a_player() -> bool:
	if (
		hitbox
		.get_overlapping_areas()
		.filter(func (a): return true if a.get_parent() is Player else false)
		.is_empty()
	):
		print("target isnt a player")

	return not (
		hitbox
		.get_overlapping_areas()
		.filter(func (a): return true if a.get_parent() is Player else false)
		.is_empty()
	)
