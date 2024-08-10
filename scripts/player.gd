extends CharacterBody2D
class_name Player

const SPEED = 200.0
const TILE_SIZE = 32

signal update_resources(gears: int)

@onready var world = $".."
@onready var tower_scene: Resource = preload("res://scenes/towers/tower.tscn")

var gears: int = 100
var tower_cost: int = 10

func _physics_process(delta):
	var input_vector = get_input_vector()
	
	handle_movement(input_vector, delta)
	
	if(Input.is_action_just_pressed("ui_accept")) and gears >= tower_cost:
		spawn_tower()

func get_input_vector() -> Vector2:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_axis("ui_left", "ui_right")
	input_vector.y = Input.get_axis("ui_up", "ui_down")
	return input_vector

func handle_movement(input_vector: Vector2, delta: float) -> void:
	if input_vector:
		velocity = input_vector.normalized() * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	
	move_and_slide()

func spawn_tower() -> void:
	var tower = tower_scene.instantiate()
	var mouse_position = (get_global_mouse_position() + Vector2(TILE_SIZE/2, TILE_SIZE/2)) / TILE_SIZE
	
	world.add_child(tower)
	tower.global_position = Vector2(mouse_position.floor() * TILE_SIZE) 
	tower.name = "Tower"
	
	gears -= tower_cost
	update_resources.emit(gears)
