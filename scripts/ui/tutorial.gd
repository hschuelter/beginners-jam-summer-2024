extends Control
@onready var label = $Label

const TIME = 4

func _ready():
	self.visible = true
	await get_tree().create_timer(TIME).timeout
	label.text = "They will arrive at 18"
	await get_tree().create_timer(TIME).timeout
	self.visible = false

func explore():
	label.text = "I should explore the area they are coming from"
	self.visible = true
	await get_tree().create_timer(TIME).timeout
	self.visible = false
	
