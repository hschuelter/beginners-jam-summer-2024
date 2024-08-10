extends Area2D
class_name Enemy

#region Constants
const ENEMY_SCENE: Resource = preload("res://scenes/enemies/enemy.tscn")
#endregion

#region Node Childs
@onready var damage_number_origin = $DamageNumberOrigin
@onready var drop_component = $DropComponent
@onready var health_component = $HealthComponent
#endregion

@export var max_health: float = 30
@export var drop_rate: float = 0.30
@export var drop_value: int = 2
@export var speed: float = 30.0
@export var damage: float = 10.0

var player: Player
var target = Vector2.ZERO
var world

static func create_enemy(_player: Player, _target: Vector2, _world: Node2D, _name: String = "") -> Enemy:
	var new_enemy: Enemy = ENEMY_SCENE.instantiate()
	new_enemy.player = _player
	new_enemy.target = _target
	new_enemy.world = _world
	new_enemy.name = _name
	
	return new_enemy

func _ready():
	health_component.max_health = max_health
	health_component.current_health = max_health
	health_component.die.connect(die)
	
	drop_component.drop_rate = clamp(drop_rate, 0.0, 1.0)
	drop_component.drop_value = drop_value
	drop_component.world = world

func _process(delta):
	var direction = target - self.global_position
	
	move(direction.normalized(), delta)
	
	if(self.global_position.distance_to(target) < 5):
		queue_free()

func move(direction: Vector2, delta: float) -> void:
	self.global_position += direction * speed * delta

func die():
	drop_component.drop()
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("bullet"):
		var damage = area.damage
		health_component.damage(area.damage)
		DamageNumbers.display_number(damage, damage_number_origin.global_position)
		area.queue_free()
