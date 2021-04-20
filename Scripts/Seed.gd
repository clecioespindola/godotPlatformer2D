extends Area2D

var velocity = Vector2.ZERO
var shoot_speed = -100
var direction = 1

func _physics_process(delta: float) -> void:
	velocity.x = shoot_speed * direction * delta
	
	translate(velocity)


func _on_clearNode_screen_exited() -> void:
	queue_free()
