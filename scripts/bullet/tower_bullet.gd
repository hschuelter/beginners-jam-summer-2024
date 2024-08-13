class_name TowerBullet extends Bullet

const TOWER_BULLET_SCENE: Resource = preload("res://scenes/bullet/tower_bullet.tscn")

var enemy: Enemy

static func create_bullet(_damage: float, _enemy, _name: String) -> Bullet:
	var new_tower_bullet: TowerBullet = TOWER_BULLET_SCENE.instantiate()
	new_tower_bullet.damage = _damage
	new_tower_bullet.enemy = _enemy
	new_tower_bullet.name = _name
	
	return new_tower_bullet

func _process(delta):
	if enemy != null:
		target = enemy.global_position
		var direction = target - self.global_position
		
		move(direction.normalized(), delta)
	else:
		queue_free()
