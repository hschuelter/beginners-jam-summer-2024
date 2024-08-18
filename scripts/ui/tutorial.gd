extends Control

@onready var label = $Label

const TIME = 5

func _ready():
	self.visible = true
	await get_tree().create_timer(4).timeout
	label.text = "They will probably arrive at 18:00..."
	await get_tree().create_timer(4).timeout
	label.text = "I need to get resources to build towers to defend my family!"
	await get_tree().create_timer(5).timeout
	self.visible = false

func explore():
	await get_tree().create_timer(5).timeout
	var tween_duration := 2
	label.text = "I should explore the area they are coming from!"
	label.visible_ratio = 0.0
	self.visible = true
	var tween := create_tween()
	tween.tween_property(label, "visible_ratio", 1.0, tween_duration)
	await get_tree().create_timer(9).timeout
	self.visible = false
	
