extends Node2D

@onready var world = $".."
@onready var spawn_timer = $SpawnTimer
@onready var enemy_scene: Resource = preload("res://scenes/enemies/enemy.tscn")

@export var player: Player

var rng = RandomNumberGenerator.new()
var spawn_points = [
	Vector2(    0, -360), # North
	Vector2(    0,  360), # South
	Vector2(  360,    0), # East
	Vector2( -360,    0)  # West
]
var can_spawn: bool = false

func _ready():
	spawn_timer.start()

func _process(delta):
	pass

func get_random_spawn_point() -> Vector2:
	var num = rng.randi_range(0, spawn_points.size() - 1)
	return spawn_points[num]

func spawn_enemy(_position: Vector2) -> void:
	var new_enemy: Enemy = Enemy.create_enemy(player, Vector2.ZERO, world, "Enemy")
	world.add_child(new_enemy)
	new_enemy.global_position = _position
	
	spawn_timer.start()

func change_daytime(is_day: bool) -> void:
	can_spawn = not is_day
	print("can spawn? " + str(can_spawn))

func _on_spawn_timer_timeout() -> void:
	if can_spawn:
	#var position: Vector2 = get_random_spawn_point()
		for pos in spawn_points:
			spawn_enemy(pos)
