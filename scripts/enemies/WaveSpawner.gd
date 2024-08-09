extends Node2D

@onready var world = $".."
@onready var spawn_timer = $SpawnTimer

@export var player: Player
@export var enemy_scene: Resource = preload("res://scenes/enemies/enemy.tscn")

var rng = RandomNumberGenerator.new()
var spawn_points = [
	Vector2(    0, -180), # North
	Vector2(    0,  180), # South
	Vector2(  360,    0), # East
	Vector2( -360,    0)  # West
]

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	
func get_random_spawn_point() -> Vector2:
	var num = rng.randi_range(0, spawn_points.size() - 1)
	return spawn_points[num]
	
func spawn_enemy(position: Vector2) -> void:
	var spawned_enemy: Enemy = enemy_scene.instantiate()
	
	spawned_enemy.player = player
	spawned_enemy.name = "Enemy"
	world.add_child(spawned_enemy)
	spawned_enemy.global_position = position
	spawn_timer.start()
	print("spawnei")
	
func _on_spawn_timer_timeout() -> void:
	var position: Vector2 = get_random_spawn_point()
	spawn_enemy(position)
