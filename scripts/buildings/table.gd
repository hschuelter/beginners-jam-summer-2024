class_name Table extends Area2D

signal open_upgrade_ui
signal close_upgrade_ui

@onready var outline = $Outline

@export var player: Player
@export var distance: float = 40

func _ready():
	outline.visible = false


func _process(delta):
	if global_position.distance_to(player.global_position) < distance:
		outline.visible = true
		if(Input.is_action_just_pressed("ui_accept")):
			open_upgrade_ui.emit()
	else:
		outline.visible = false
		close_upgrade_ui.emit()
