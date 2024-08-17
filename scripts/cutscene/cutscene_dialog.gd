extends RichTextLabel
const world_scene = "res://scenes/world.tscn"
@onready var next_button = $"../NextButton"

var dialogue_items: Array[String]=[
	"I smell foxes coming from the West...",
	"I need to destroy boxes to gather resources...",
	"Only then I will be able to build towers...",
	"And protect my family from those mosnters!"
]

var current_item_index := 0

func _ready():
	show_text()
	next_button.pressed.connect(next_text)
	self.visible_ratio = 0.0

func show_text():
	next_button.disabled = true
	visible_ratio = 0
	var tween_duratin := 1.5
	var current_item := dialogue_items[current_item_index]
	self.text = current_item
	var tween := create_tween()
	tween.tween_property(self, "visible_ratio", 1.0, tween_duratin)
	await tween.finished
	next_button.disabled = false


func next_text():
	if current_item_index < dialogue_items.size()-1:
		current_item_index += 1
		show_text()
		if current_item_index == 3:
			next_button.text = "PLAY!"

	else: 
		$"../AnimationPlayer".play("black_screen_on")
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file(world_scene)
