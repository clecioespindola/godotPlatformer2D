extends Area2D


func _on_fallzone_body_entered(body: Node) -> void:
	if body.name == "Player":
		if get_tree().change_scene("res://Prefabs/GameOver.tscn") != OK:
			print("Algo deu errado!")
