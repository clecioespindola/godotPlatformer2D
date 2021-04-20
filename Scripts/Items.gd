extends Area2D

export var fruits = 1

func _on_items_body_entered(_body: Node) -> void:
	$collectedFx.play()
	$anim.play("collected")
	Global.fruits += fruits
	print(Global.fruits)
	
func _on_anim_animation_finished(anim_name: String) -> void:
	if anim_name == "collected":
		queue_free()
