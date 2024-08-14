extends Node2D

@export var camera: Camera2D
@export var player: Player

enum Dir {LEFT, TOP, RIGHT, BOTTOM}

#region Const
const default_camera_limits: Dictionary = {
	Dir.LEFT: -374,
	Dir.TOP: -374,
	Dir.RIGHT: 374,
	Dir.BOTTOM: 374
}

const sidescreen_camera_limits: Dictionary = {
	Dir.LEFT: {Dir.LEFT: -1122, Dir.RIGHT: -376},
	Dir.TOP: {Dir.TOP: -570, Dir.BOTTOM: -192},
	Dir.RIGHT: {Dir.LEFT: 376, Dir.RIGHT: 1122},
	Dir.BOTTOM: {Dir.TOP: 192, Dir.BOTTOM: 570}
}
#endregion

#region Var
var is_on_sidescreen: Dictionary = {
	Dir.LEFT: false,
	Dir.TOP: false,
	Dir.RIGHT: false,
	Dir.BOTTOM: false
}
#endregion

func _ready():
	camera.limit_left = default_camera_limits[Dir.LEFT]
	camera.limit_top = default_camera_limits[Dir.TOP]
	camera.limit_right = default_camera_limits[Dir.RIGHT]
	camera.limit_bottom = default_camera_limits[Dir.BOTTOM]
	camera.limit_smoothed = true


func _process(delta):
	# left screen
	if player.global_position.x < default_camera_limits[Dir.LEFT] and not is_on_sidescreen[Dir.LEFT]:
		camera.limit_left = sidescreen_camera_limits[Dir.LEFT][Dir.LEFT]
		camera.limit_right = sidescreen_camera_limits[Dir.LEFT][Dir.RIGHT]
		is_on_sidescreen[Dir.LEFT] = true
	elif player.global_position.x >= default_camera_limits[Dir.LEFT] and is_on_sidescreen[Dir.LEFT]:
		camera.limit_left = default_camera_limits[Dir.LEFT]
		camera.limit_right = default_camera_limits[Dir.RIGHT]
		is_on_sidescreen[Dir.LEFT] = false
		
	# right screen
	if player.global_position.x > default_camera_limits[Dir.RIGHT] and not is_on_sidescreen[Dir.RIGHT]:
		camera.limit_left = sidescreen_camera_limits[Dir.RIGHT][Dir.LEFT]
		camera.limit_right = sidescreen_camera_limits[Dir.RIGHT][Dir.RIGHT]
		is_on_sidescreen[Dir.RIGHT] = true
	elif player.global_position.x <= default_camera_limits[Dir.RIGHT] and is_on_sidescreen[Dir.RIGHT]:
		camera.limit_left = default_camera_limits[Dir.LEFT]
		camera.limit_right = default_camera_limits[Dir.RIGHT]
		is_on_sidescreen[Dir.RIGHT] = false
		
	# bottom screen
	if player.global_position.y > default_camera_limits[Dir.BOTTOM] and not is_on_sidescreen[Dir.BOTTOM]:
		camera.limit_top = sidescreen_camera_limits[Dir.BOTTOM][Dir.TOP]
		camera.limit_bottom = sidescreen_camera_limits[Dir.BOTTOM][Dir.BOTTOM]
		is_on_sidescreen[Dir.BOTTOM] = true
	elif player.global_position.y <= default_camera_limits[Dir.BOTTOM] and is_on_sidescreen[Dir.BOTTOM]:
		camera.limit_top = default_camera_limits[Dir.TOP]
		camera.limit_bottom = default_camera_limits[Dir.BOTTOM]
		is_on_sidescreen[Dir.BOTTOM] = false
		
	# top screen
	if player.global_position.y < default_camera_limits[Dir.TOP] and not is_on_sidescreen[Dir.TOP]:
		camera.limit_top = sidescreen_camera_limits[Dir.TOP][Dir.TOP]
		camera.limit_bottom = sidescreen_camera_limits[Dir.TOP][Dir.BOTTOM]
		is_on_sidescreen[Dir.TOP] = true
	elif player.global_position.y >= default_camera_limits[Dir.TOP] and is_on_sidescreen[Dir.TOP]:
		camera.limit_top = default_camera_limits[Dir.TOP]
		camera.limit_bottom = default_camera_limits[Dir.BOTTOM]
		is_on_sidescreen[Dir.TOP] = false
