class_name PlayerBullet extends Bullet

const PLAYER_BULLET_SCENE = preload("res://scenes/bullet/player_bullet.tscn")

static func create_player_bullet(_damage: float, _target, _name: String) -> PlayerBullet:
	var new_bullet: PlayerBullet = PLAYER_BULLET_SCENE.instantiate()
	new_bullet.damage = _damage
	new_bullet.target = _target
	new_bullet.name = _name
	
	return new_bullet
