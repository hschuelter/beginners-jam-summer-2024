extends Node2D

const ENEMY = preload("res://scenes/enemies/enemy.tscn")
const ENEMY_HEAVY = preload("res://scenes/enemies/enemy_heavy.tscn")
const ENEMY_LIGHT = preload("res://scenes/enemies/enemy_light.tscn")

signal update_danger_zone(positions)
signal show_arrows(positions)
signal player_victory
signal explore_tutorial


@onready var world = $".."
@onready var spawn_timer = $SpawnTimer
@export var player: Player

var rng = RandomNumberGenerator.new()
var spawn_points = [
	Vector2(    0, -360), # North - 0
	Vector2(    0,  360), # South - 1
	Vector2(  360,    0), # East  - 2
	Vector2( -360,    0)  # West  - 3
]
var can_spawn: bool = false

var waves = [
	[3],
	[2, 3],
	[0, 3],
	[1, 2, 3],
	[0, 1, 2, 3],
]
var current_wave: int = 0
var current_type: int = 0

func _ready():
	spawn_timer.start()
	
	player_victory.connect(world.player_victory)

func _process(delta):
	pass

func get_random_spawn_point() -> Vector2:
	var num = rng.randi_range(0, spawn_points.size() - 1)
	return spawn_points[num]

func spawn_enemy(_position: Vector2, _type: int) -> void:
	var new_enemy: Enemy = Enemy.create_enemy(player, Vector2.ZERO, world, _type, "Enemy")
	world.add_child(new_enemy)
	new_enemy.global_position = _position
	
	spawn_timer.start()

func change_daytime(is_day: bool) -> void:
	can_spawn = not is_day
	player.health_component.heal(30)
	current_wave = WorldState._current_day
	if current_wave == 5:
		player_victory.emit()
	else:
		if current_type == 0 and current_wave == 1:
			current_type = 1
			explore_tutorial.emit()
		if current_wave == 3:
			current_type = 2
		update_danger_zone.emit(waves[current_wave])
		show_arrows.emit(waves[current_wave])

func _on_spawn_timer_timeout() -> void:
	if can_spawn:
		for pos in waves[current_wave]:
			spawn_enemy(spawn_points[pos], current_type)
