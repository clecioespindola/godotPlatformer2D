extends enemyBase

func _process(delta: float) -> void:
	motion.y = 0
	if $ray_wall.is_colliding():
		$ray_wall.scale.x *= -1
		move_direction *= -1
		$anim.play("run")
