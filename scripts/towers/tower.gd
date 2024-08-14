class_name Tower extends Node2D

const TOWER_SCENE = preload("res://scenes/towers/tower.tscn")

@export var tower_damage: float = 10
@export var tower_range: float = 80
@export var tower_cooldown: float = 1.0

@onready var world = $".."
@onready var collision_shape_2d = $Range/CollisionShape2D
@onready var shoot_timer = $ShootTimer
@onready var range_sprite = $Range/Sprite2D

var can_shoot: bool = false
var enemy_queue: Array[Enemy]
var target: Enemy

static func create_tower(_damage: float, _range: float, _cooldown: float) -> Tower:
	var new_tower: Tower = TOWER_SCENE.instantiate()
	new_tower.tower_damage = _damage
	new_tower.tower_range = _range
	new_tower.tower_cooldown = _cooldown
	return new_tower

func _ready():
	var circle_shape_2d = CircleShape2D.new()
	circle_shape_2d.radius = tower_range
	
	self.shoot_timer.wait_time = tower_cooldown
	self.shoot_timer.start()
	self.collision_shape_2d.shape = circle_shape_2d
	self.range_sprite.scale = Vector2(tower_range, tower_range) / 100
	self.enemy_queue = []
	self.target = null

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
	var bullet: TowerBullet = TowerBullet.create_bullet(tower_damage, target, "Bullet")
	world.add_child(bullet)
	bullet.global_position = self.global_position
	
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


func _on_range_body_entered(enemy):
	if enemy.is_in_group("enemy"):
		enemy_queue.push_back(enemy)

func _on_range_body_exited(enemy):
	if enemy.is_in_group("enemy"):
		enemy_queue.erase(enemy)
