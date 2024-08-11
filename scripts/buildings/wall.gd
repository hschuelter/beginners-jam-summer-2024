extends Area2D
class_name Wall

const MAX_DISTANCE_TO_SELECT = 32

signal wall_selected(wall: Wall)

@onready var health_component = $HealthComponent
@onready var damage_number_origin = $DamageNumberOrigin
@onready var sprite_outline = $SpriteOutline

@export var max_health: float = 100
var player: Player
var is_selected: bool = false

func _ready():
	health_component.max_health = max_health
	health_component.current_health = max_health
	health_component.die.connect(die)
	
	sprite_outline.visible = false

func _process(delta):
	var distance = self.global_position.distance_to(player.global_position)
	if is_selected and distance > MAX_DISTANCE_TO_SELECT:
		sprite_outline.visible = false
		is_selected = false
		wall_selected.emit(null)

func die():
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("enemy"):
		var damage: float = area.damage
		area.queue_free()
		DamageNumbers.display_number(damage, damage_number_origin.global_position)
		health_component.damage(damage)


func _on_mouse_hover_range_mouse_entered():
	var distance = self.global_position.distance_to(player.global_position)
	if distance <= MAX_DISTANCE_TO_SELECT:
		sprite_outline.visible = true
		is_selected = true
		wall_selected.emit(self)


func _on_mouse_hover_range_mouse_exited():
	sprite_outline.visible = false
	is_selected = false
	wall_selected.emit(null)
