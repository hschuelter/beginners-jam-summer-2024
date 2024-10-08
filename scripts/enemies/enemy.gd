class_name Enemy extends CharacterBody2D

#region Constants
const ENEMY_SCENE: Resource = preload("res://scenes/enemies/enemy.tscn")
const ENEMY_HEAVY = preload("res://scenes/enemies/enemy_heavy.tscn")
const ENEMY_LIGHT = preload("res://scenes/enemies/enemy_light.tscn")
const WALL_HIT = preload("res://assets/sfx/wall_hit.wav")
#endregion
signal game_over

#region Node Childs
@onready var damage_number_origin = $DamageNumberOrigin
@onready var fov: Area2D = $FOV
@onready var hitbox: Area2D = $Hitbox 
@onready var hurtbox = $Hurtbox
@onready var raycast = $RayCast2D
@onready var drop_component = $DropComponent
@onready var health_component = $HealthComponent
@onready var slow_timer = $SlowTimer
@onready var attack_cd_timer = $AttackCdTimer
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var sfx = $sfx
#endregion


@export var max_health: float = 30
@export var drop_rate: float = 0.30
@export var drop_value: int = 10
@export var speed: float = 35.0
@export var damage: float = 10.0
@export var is_static: bool = false

var player: Player
var target = Vector2.ZERO
var world

var is_slowed: bool = false
var slow_value: float = 0.5
var building_on_range: Node = null
var can_attack: bool = true

var default_speed: float = 35

static func create_enemy(_player: Player, _target: Vector2, _world: Node2D, _type: int, _name: String = "") -> Enemy:
	var new_enemy: Enemy
	if _type == 0:
		new_enemy = ENEMY_SCENE.instantiate()
	if _type == 1:
		new_enemy = ENEMY_LIGHT.instantiate()
	if _type == 2:
		new_enemy = ENEMY_HEAVY.instantiate()
	
	new_enemy.player = _player
	new_enemy.target = _target
	new_enemy.world = _world
	new_enemy.name = _name
	
	return new_enemy

func _ready():
	if world == null:
		world = get_parent().get_parent()
		
	if player == null:
		player = get_parent().get_parent().get_node("Player")
		
	health_component.max_health = max_health
	health_component.current_health = max_health
	health_component.die.connect(die)
	
	drop_component.drop_rate = clamp(drop_rate, 0.0, 1.0)
	drop_component.drop_value = drop_value
	drop_component.world = world
	
	if speed != 0:
		default_speed = speed
	
	game_over.connect(world.game_over)
	attack_cd_timer.timeout.connect(_on_attack_cd_timeout)
	sfx.stream = WALL_HIT

func _process(delta):
	var direction = target - self.global_position
	move(direction.normalized(), delta)
	handle_animation(direction)


func move(direction: Vector2, delta: float) -> void:
	var _speed = speed
	
	if is_slowed:
		_speed *= slow_value
	
	velocity = direction * _speed
	move_and_slide()
	

func handle_animation(direction: Vector2) -> void:
	if direction == Vector2.ZERO and target_in_attack_range() == []:
		animated_sprite_2d.play("idle")
	
	if direction.x < 0:
		animated_sprite_2d.scale.x = -1
	else:
		animated_sprite_2d.scale.x = 1
	

func die():
	drop_component.drop()
	queue_free()


func attack(target: Node) -> void:
	if can_attack:
		animated_sprite_2d.play("attack")
		can_attack = false
		speed = 0
		attack_cd_timer.start()
		await get_tree().create_timer(0.25).timeout
		sfx._play()
		if target != null:
			target.take_damage(damage)


func set_target_position(pos: Vector2) -> void:
	animated_sprite_2d.play("run")
	target = pos


func is_player_in_fov() -> bool:
	var player_in_fov = (fov
			.get_overlapping_areas()
			.filter(func (a): return true if a.get_parent() is Player else false)
	)

	if player_in_fov.is_empty():
		raycast.enabled = false
		return false

	raycast.enabled = true
	raycast.target_position = player_in_fov[0].global_position - raycast.global_position
	var raycast_collider = raycast.get_collider()
	if raycast_collider is Node and raycast_collider.is_in_group("player"):
		return true

	return false


func get_player_position() -> Vector2:
	speed = default_speed

	return (fov
			.get_overlapping_areas()
			.filter(func (a): return true if a.get_parent() is Player else false)[0]
			.global_position
	)


func target_in_attack_range():
	if building_on_range:
		return [building_on_range]
	var possible_targets = hitbox.get_overlapping_areas()
	
	return possible_targets


func is_target_a_player() -> bool:
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
	if body.is_in_group("building"):
		building_on_range = body


func _on_hitbox_area_entered(area):
	if area.is_in_group("world_center"):
		game_over.emit()


func _on_hitbox_body_exited(body):
	if body.is_in_group("building"):
		building_on_range = null


func _on_attack_cd_timeout():
	can_attack = true
	if not is_static:
		speed = default_speed


func _on_fov_body_exited(body):
	if body is Player and is_static:
		speed = 0
		target = Vector2.ZERO
