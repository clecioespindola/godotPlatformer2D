extends Area2D

var duration = 0

func _ready() -> void:
	pass

func _on_wait_timer_timeout() -> void:
	$anim.play("on")
	$fireCol.set_deferred("disabled", false)
	
func _on_stop_timer_timeout() -> void:
	$anim.play("off")
	$fireCol.set_deferred("disabled", true)


func _on_Area2D_body_entered(body: Node) -> void:
	if body.has_method("damagePlayer"):
		body.damagePlayer()
