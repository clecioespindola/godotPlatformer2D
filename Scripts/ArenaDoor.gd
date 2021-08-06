extends StaticBody2D

signal DoorClosed

func _ready():
	pass


func _on_Trigger_PlayerEntered() -> void:
	$anim.play("active")
	yield(get_tree().create_timer(1), "timeout")
	emit_signal("DoorClosed")


func _on_Boss_BossDead() -> void:
	$anim.play("inactive")
