extends Node2D

@onready var arrow_north = $ArrowNorth
@onready var arrow_south = $ArrowSouth
@onready var arrow_east = $ArrowEast
@onready var arrow_west = $ArrowWest

var north = Vector2(0, -350)
var north_active: bool = false

var south = Vector2(0, 350)
var south_active: bool = false

var east = Vector2(350, 0)
var east_active: bool = false

var west = Vector2(-350, 0)
var west_active: bool = true


func _ready():
	arrow_north.visible = false
	arrow_south.visible = false
	arrow_east.visible = false
	arrow_west.visible = true

func show_arrows(positions):
	arrow_north.visible = false
	north_active = false
	
	arrow_south.visible = false
	south_active = false
	
	arrow_east.visible = false
	east_active = false
	
	arrow_west.visible = false
	west_active = false
	
	for p in positions:
		if p == 0: 
			arrow_north.visible = true
			north_active = true
		elif p == 1: 
			arrow_south.visible = true
			south_active = true
		elif p == 2: 
			arrow_east.visible = true
			east_active = true
		elif p == 3: 
			arrow_west.visible = true
			west_active = true

func _process(delta):
	arrow_north.rotation_degrees =  90 + (north - arrow_north.global_position).angle() * 180 / PI
	arrow_south.rotation_degrees = 90 + (south - arrow_south.global_position).angle() * 180 / PI
	arrow_east.rotation_degrees =  90 + (east - arrow_east.global_position).angle() * 180 / PI
	arrow_west.rotation_degrees =  90 + (west - arrow_west.global_position).angle() * 180 / PI
	
	if north_active:
		if (arrow_north.global_position - north).length() >= 120 and arrow_north.global_position.y > north.y:
			arrow_north.visible = true
		else:
			arrow_north.visible = false
	
	if south_active:
		if (arrow_south.global_position - south).length() >= 120 and arrow_south.global_position.y < south.y:
			arrow_south.visible = true
		else:
			arrow_south.visible = false
	
	if east_active:
		if (arrow_east.global_position - east).length() >= 120 and arrow_east.global_position.x < east.x:
			arrow_east.visible = true
		else:
			arrow_east.visible = false
	
	if west_active:
		if (arrow_west.global_position - west).length() >= 120 and arrow_west.global_position.x > west.x:
			arrow_west.visible = true
		else:
			arrow_west.visible = false
		
