extends BeehaveTree

@export var gates: Array[Node]
@export var fov: Area2D
@export var hitbox: Area2D

func _ready():
	$Either/TaskMoveToNearestGate.set_static_targets(gates)
	$Either/Attack/CheckTargetInAttackRange.set_fov(fov)
	$Either/Attack/CheckTargetInAttackRange.set_hitbox(hitbox)
	$Either/Follow/CheckPlayerInFov.set_fov(fov)
