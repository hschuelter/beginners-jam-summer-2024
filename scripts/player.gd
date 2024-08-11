extends CharacterBody2D
class_name Player

const SPEED = 200.0

signal update_resources(gears: int)
signal update_toolbox(current_tool: int)

@onready var world = $".."
@onready var gun_tool = $GunTool
@onready var build_tool = $BuildTool
@onready var repair_tool = $RepairTool
@onready var health_component = $HealthComponent
@onready var resources_component = $ResourcesComponent

@export var starting_gears: int = 100
@export var max_health: int = 10

enum States {
	GUN,
	BUILD, 
	REPAIR
}
var current_state: States = States.GUN
var tower_cost: int = 10
var selected_wall: Wall

func _ready():
	gun_tool.world = world
	build_tool.world = world
	repair_tool.world = world
	
	resources_component.gears = starting_gears
	health_component.max_health = max_health
	health_component.current_health = max_health
	

func _physics_process(delta):
	var input_vector = get_input_vector()	
	handle_movement(input_vector, delta)
	handle_tool()
	
	if current_state == States.GUN:
		if(Input.is_action_just_pressed("mouse_left")):
			gun_tool.action()
		
	elif current_state == States.BUILD:
		var can_build = resources_component.can_build(tower_cost)
		if(Input.is_action_just_pressed("mouse_left")) and can_build:
			build_tool.action()
			resources_component.spend(tower_cost)
	
	elif current_state == States.REPAIR:
		if(Input.is_action_just_pressed("mouse_left")):
			repair_tool.wall = selected_wall
			repair_tool.action()
	

func handle_tool() -> void:
	var last_state = current_state
	if(Input.is_action_just_pressed("num_1")):
		current_state = States.GUN
	if(Input.is_action_just_pressed("num_2")):
		current_state = States.BUILD
	if(Input.is_action_just_pressed("num_3")):
		current_state = States.REPAIR
	
	if(Input.is_action_just_pressed("mouse_scroll_down")):
		current_state = (current_state + 1) % States.size()
	
	if(Input.is_action_just_pressed("mouse_scroll_up")):
		current_state = (States.size() + current_state - 1) % States.size()
	
	if last_state != current_state:
		update_toolbox.emit(current_state)

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

func set_wall(wall: Wall) -> void:
	selected_wall = wall

func _on_pickup_range_area_entered(area):
	if area.is_in_group("drop"):
		resources_component.collect(area.gears)
		area.queue_free()
