extends Node2D
class_name Tower

@export var tower_range: float = 60
@export var tower_damage: float = 2

@onready var world = $".."
@onready var collision_shape_2d = $Range/CollisionShape2D
@onready var bullet_scene: Resource = preload("res://scenes/bullet.tscn")

@onready var shoot_timer = $ShootTimer
var can_shoot: bool = false

var target: Enemy
var enemy_queue: Array[Enemy]

func _ready():
	shoot_timer.start()
	collision_shape_2d.shape.radius = tower_range
	enemy_queue = []
	target = null

func _process(delta):
	if target != null and abs(self.global_position.distance_to(target.global_position)) > (tower_range + 15):
		target = null

	if target == null:
		target = _get_enemy()
	
	if target != null and can_shoot:
		shoot()

func _get_enemy() -> Enemy:
	var enemy: Enemy = null
	
	if enemy_queue.is_empty():
		return null
	
	while not enemy and not enemy_queue.is_empty():
		if enemy_queue.is_empty():
			return null
		
		enemy = enemy_queue.pop_front()
		
		if enemy != null and abs(self.global_position.distance_to(enemy.global_position)) > (tower_range + 15):
			enemy = null
			continue
	
	return enemy

func shoot() -> void:
	#print("Current target " + target.name)
	var bullet = bullet_scene.instantiate()
	
	world.add_child(bullet)
	bullet.global_position = self.global_position
	bullet.target = target
	bullet.damage = tower_damage
	bullet.name = "Bullet"
	shoot_timer.start()
	can_shoot = false

func _on_range_area_entered(enemy):
	if enemy.is_in_group("enemy"):
		enemy_queue.push_back(enemy)
		#print(enemy.name + " has entered")


func _on_range_area_exited(enemy):
	if enemy.is_in_group("enemy"):
		enemy_queue.erase(enemy)
		#print(enemy.name + " has exited")


func _on_shoot_timer_timeout():
	can_shoot = true
