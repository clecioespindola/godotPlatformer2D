extends Area2D

func _ready():
	pass


func _on_Fire_body_entered(body: Node) -> void:
	if body.has_method("playerDamage"):
		body.playerDamage()


func _on_startTimer_timeout() -> void:
	$anim.play("on")
	$FireCol.set_deferred("disabled", false)


func _on_stopTimer_timeout() -> void:
	$anim.play("off")
	$FireCol.set_deferred("disabled", true)
