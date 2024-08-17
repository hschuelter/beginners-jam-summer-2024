extends Node2D

const world_scene = "res://scenes/world.tscn"
const cutscene = "res://scenes/cutscene/cut_scene.tscn"

@onready var start_game_button = $CanvasLayer/StartGameButton
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var animation_player = $AnimationPlayer
@onready var transition_screen = $CanvasLayer/TransitionScreen

func _ready():
	Engine.max_fps = 60
	audio_stream_player_2d.play()
	transition_screen.visible = false

func _on_start_game_button_pressed():
	transition_screen.visible = true
	animation_player.play("begin")

func start_game():
	get_tree().change_scene_to_file(world_scene)
	
