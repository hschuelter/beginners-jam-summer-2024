extends Node2D

@onready var sprite_north = $SpriteNorth
@onready var sprite_south = $SpriteSouth
@onready var sprite_east = $SpriteEast
@onready var sprite_west = $SpriteWest

func update_danger_zone(positions):
	sprite_north.visible = false
	sprite_south.visible = false
	sprite_east.visible = false
	sprite_west.visible = false
	
	for p in positions:
		if p == 0: sprite_north.visible = true
		elif p == 1: sprite_south.visible = true
		elif p == 2: sprite_east.visible = true
		elif p == 3: sprite_west.visible = true
