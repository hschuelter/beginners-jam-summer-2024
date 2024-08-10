extends Node2D

@onready var world = $".."
@onready var spawn_timer = $SpawnTimer
@onready var enemy_scene: Resource = preload("res://scenes/enemies/enemy.tscn")

@export var player: Player

var rng = RandomNumberGenerator.new()
var spawn_points = [
	#Vector2(    0, -180), # North
	#Vector2(    0,  180), # South
	#Vector2(  360,    0), # East
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

func spawn_enemy(_position: Vector2) -> void:
	var new_enemy: Enemy = Enemy.create_enemy(player, Vector2.ZERO, world, "Enemy")
	world.add_child(new_enemy)
	new_enemy.global_position = _position
	
	spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
	#var position: Vector2 = get_random_spawn_point()
	for pos in spawn_points:
		spawn_enemy(pos)
