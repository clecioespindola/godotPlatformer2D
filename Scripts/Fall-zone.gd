extends Area2D


func _on_fallzone_body_entered(body: Node) -> void:
	print(body.name)
	get_tree().reload_current_scene()
