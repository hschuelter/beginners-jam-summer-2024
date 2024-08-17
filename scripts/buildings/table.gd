class_name Table extends StaticBody2D

@onready var upgrade_label = $UpgradeLabel
signal open_upgrade_ui
signal close_upgrade_ui

@onready var outline = $Outline

@export var player: Player
@export var distance: float = 40

var is_in_range: bool = false

func _ready():
	outline.visible = false
	is_in_range = false


func _process(delta):
	if is_in_range:
		if(Input.is_action_just_pressed("ui_accept")):
			open_upgrade_ui.emit()
	

func _on_range_body_entered(body):
	if body.is_in_group("player"):
		outline.visible = true
		is_in_range = true


func _on_range_body_exited(body):
	if body.is_in_group("player"):
		outline.visible = false
		is_in_range = false
		close_upgrade_ui.emit()

func _on_button_pressed():
	print("oi")
	outline.visible = true
	is_in_range = true
	open_upgrade_ui.emit()

