extends CharacterBody2D
class_name Player

const SPEED = 200.0

signal update_resources(gears: int)
signal update_toolbox(current_tool: int)

@onready var world = $".."
@onready var gun_tool = $GunTool
@onready var build_tool = $BuildTool
@onready var repair_tool = $RepairTool

enum States {
	GUN,
	BUILD, 
	REPAIR
}
var current_state: States = States.GUN

var gears: int = 100
var tower_cost: int = 10

func _ready():
	gun_tool.world = world
	build_tool.world = world
	repair_tool.world = world
	

func _physics_process(delta):
	var input_vector = get_input_vector()	
	handle_movement(input_vector, delta)
	handle_tool()
	
	if current_state == States.GUN:
		if(Input.is_action_just_pressed("mouse_left")):
			gun_tool.action()
		
	elif current_state == States.BUILD:
		if(Input.is_action_just_pressed("mouse_left")) and gears >= tower_cost:
			build_tool.action()
			gears -= tower_cost
			update_resources.emit(gears)
	
	elif current_state == States.REPAIR:
		if(Input.is_action_just_pressed("mouse_left")):
			repair_tool.action()
	

func handle_tool() -> void:
	var last_state = current_state
	if(Input.is_action_just_pressed("num_1")):
		current_state = States.GUN
	if(Input.is_action_just_pressed("num_2")):
		current_state = States.BUILD
	if(Input.is_action_just_pressed("num_3")):
		current_state = States.REPAIR
	
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

func _on_pickup_range_area_entered(area):
	if area.is_in_group("drop"):
		self.gears += area.gears
		update_resources.emit(gears)
		area.queue_free()
