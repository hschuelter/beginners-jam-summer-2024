class_name Player extends CharacterBody2D

const SPEED = 120.0
const PLAYER_HIT = preload("res://assets/sfx/player_hit.wav")

signal update_resources(gears: int)
signal update_toolbox(current_tool: int)

@onready var world = $".."
@onready var gun_tool = %GunTool
@onready var build_tool = %BuildTool
@onready var repair_tool = %RepairTool
@onready var hammer_tool = %HammerTool
@onready var health_component = $HealthComponent
@onready var resources_component = $ResourcesComponent
@onready var player_sprite = $PlayerSprite
@onready var arrows = $Arrows
@onready var sfx = $sfx

@export var starting_gears: int = 0
@export var max_health: int = 10

enum States {
	GUN,
	BUILD, 
	REPAIR,
	HAMMER
}
var current_state: States = States.GUN

enum Towers { BASIC, SLOW, SNIPER }
var current_tower: Towers = Towers.BASIC 
var tower_cost: int = 10
var mouse_on_field: bool = true

var last_input := Vector2.ZERO

func _ready():
	gun_tool.world = world
	build_tool.world = world
	repair_tool.world = world
	hammer_tool.world = world
	
	build_tool.spend_resources.connect(spend_resources)
	
	resources_component.gears = starting_gears
	health_component.max_health = max_health
	health_component.current_health = max_health
	
	player_sprite.play("idle")
	sfx.stream = PLAYER_HIT


func _physics_process(delta):
	var input_vector = get_input_vector()
	var mouse_position = get_global_mouse_position()
	
	handle_movement(input_vector, delta)
	handle_animation(input_vector)
	handle_tool()
	
	if current_state == States.GUN:
		if(Input.is_action_pressed("mouse_left")):
			gun_tool.action()
		
	elif current_state == States.BUILD:
		var can_build = resources_component.can_build(build_tool.evaluate_cost(self.current_tower))
		var distance: float = self.global_position.distance_to(mouse_position)
		if(Input.is_action_just_pressed("mouse_left")) and can_build and mouse_on_field: # and distance < 50:
			build_tool.current_tower = self.current_tower
			build_tool.action()
			#resources_component.spend(tower_cost)
	
	elif current_state == States.REPAIR:
		if(Input.is_action_pressed("mouse_left")):
			repair_tool.action()
	
	elif current_state == States.HAMMER:
		if(Input.is_action_pressed("mouse_left")):
			hammer_tool.action()
	

func handle_tool() -> void:
	var last_state = current_state
	if(Input.is_action_just_pressed("num_1")):
		current_state = States.GUN
	if(Input.is_action_just_pressed("num_2")):
		current_state = States.BUILD
	if(Input.is_action_just_pressed("num_3")):
		current_state = States.REPAIR
	if(Input.is_action_just_pressed("num_4")):
		current_state = States.HAMMER
	
	if(Input.is_action_just_pressed("mouse_scroll_down")):
		current_state = (current_state + 1) % States.size()
	
	if(Input.is_action_just_pressed("mouse_scroll_up")):
		current_state = (States.size() + current_state - 1) % States.size()
	
	gun_tool.visible = current_state == States.GUN
	build_tool.visible = current_state == States.BUILD
	repair_tool.visible = current_state == States.REPAIR
	hammer_tool.visible = current_state == States.HAMMER
	
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


func take_damage(damage) -> void:
	health_component.damage(damage)
	sfx._play(0.10)
	if health_component.current_health <= 0:
		get_parent().game_over()

func handle_animation(input_vector: Vector2):
	if input_vector == Vector2.ZERO:
		player_sprite.play("idle")
	else:
		player_sprite.play("run")
		last_input = input_vector
	
	if last_input.x < 0:
		player_sprite.scale.x = -1
	else:
		player_sprite.scale.x = 1

func spend_resources(tower_cost: float):
	resources_component.spend(tower_cost)

func _on_pickup_range_area_entered(area):
	if area.is_in_group("drop"):
		resources_component.collect(area.gears)
		area.queue_free()
