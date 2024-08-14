class_name Wall extends StaticBody2D

const MAX_DISTANCE_TO_SELECT = 32

@onready var health_component = $HealthComponent
@onready var damage_number_origin = $DamageNumberOrigin
@onready var sprite_outline = $SpriteOutline

@export var max_health: float = 100
var is_selected: bool = false

func _ready():
	health_component.max_health = max_health
	health_component.current_health = max_health
	health_component.die.connect(die)
	
	sprite_outline.visible = false
	health_component.visible = true


func die():
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("enemy"):
		var damage: float = area.damage
		area.queue_free()
		DamageNumbers.display_number(damage, damage_number_origin.global_position)
		health_component.damage(damage)


#func _on_mouse_hover_range_mouse_entered():
	#sprite_outline.visible = true
	##health_component.visible = true
	#is_selected = true
#
#
#func _on_mouse_hover_range_mouse_exited():
	#sprite_outline.visible = false
	##health_component.visible = false
	#is_selected = false
