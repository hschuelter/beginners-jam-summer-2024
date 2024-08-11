extends Tool
class_name RepairTool

@onready var repair_timer = $RepairTimer

@export var repair = 10
@export var repair_cooldown: float = 1

var wall: Wall
var can_repair: bool = false

func _ready():
	repair_timer.wait_time = repair_cooldown
	repair_timer.start()

func action() -> void:
	if wall != null and can_repair:
		can_repair = false
		wall.health_component.heal(repair)


func _on_repair_timer_timeout():
	can_repair = true
