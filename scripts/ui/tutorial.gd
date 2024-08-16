extends Control
@onready var label = $Label

const TIME = 5

func _ready():
	self.visible = true
	await get_tree().create_timer(4).timeout
	label.text = "They will probably arrive at 18, \nI need to prepare to defend my family!"
	await get_tree().create_timer(7).timeout
	self.visible = false

func explore():
	label.text = "I should explore the area they are coming from..."
	self.visible = true
	await get_tree().create_timer(6).timeout
	self.visible = false
	
