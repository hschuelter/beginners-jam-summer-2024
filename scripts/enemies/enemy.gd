class_name Enemy extends CharacterBody2D

#region Constants
const ENEMY_SCENE: Resource = preload("res://scenes/enemies/enemy.tscn")
#endregion

#region Node Childs
@onready var damage_number_origin = $DamageNumberOrigin
@onready var fov: Area2D = $FOV
@onready var hitbox: Area2D = $Hitbox 
@onready var hurtbox = $Hurtbox
@onready var drop_component = $DropComponent
@onready var health_component = $HealthComponent
@onready var slow_timer = $SlowTimer
#endregion


@export var max_health: float = 30
@export var drop_rate: float = 0.30
@export var drop_value: int = 2
@export var speed: float = 30.0
@export var damage: float = 10.0

var player: Player
var target = Vector2.ZERO
var world

var is_slowed: bool = false
var slow_value: float = 0.5

static func create_enemy(_player: Player, _target: Vector2, _world: Node2D, _name: String = "") -> Enemy:
	var new_enemy: Enemy = ENEMY_SCENE.instantiate()
	new_enemy.player = _player
	new_enemy.target = _target
	new_enemy.world = _world
	new_enemy.name = _name
	
	return new_enemy

func _ready():
	health_component.max_health = max_health
	health_component.current_health = max_health
	health_component.die.connect(die)
	
	drop_component.drop_rate = clamp(drop_rate, 0.0, 1.0)
	drop_component.drop_value = drop_value
	drop_component.world = world

func _process(delta):
	var direction = target - self.global_position
	move(direction.normalized(), delta)
	
	if(self.global_position.distance_to(target) < 5):
		print("GAME OVER")
		queue_free()

func move(direction: Vector2, delta: float) -> void:
	var _speed = speed
	if is_slowed:
		_speed *= slow_value
		
	self.global_position += direction * _speed * delta

func die():
	drop_component.drop()
	queue_free()



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

func _on_slow_timer_timeout():
	is_slowed = false


func _on_hurtbox_area_entered(area):
	if area.is_in_group("bullet"):
		var damage = area.damage
		health_component.damage(area.damage)
		DamageNumbers.display_number(damage, damage_number_origin.global_position)
		area.queue_free()


func _on_hurtbox_body_entered(body):
	if body.is_in_group("bullet"):
		var damage = body.damage
		health_component.damage(body.damage)
		DamageNumbers.display_number(damage, damage_number_origin.global_position)
		body.queue_free()


func _on_hitbox_body_entered(body):
	print(body)
	if body.is_in_group("building"):
		body.health_component.damage(damage)
		DamageNumbers.display_number(damage, body.damage_number_origin.global_position)
		self.queue_free()
	pass # Replace with function body.
