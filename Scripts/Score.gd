extends Label

func _process(_delta: float) -> void:
	text = "000" + String(Global.fruits)
	if Global.fruits >= 10:
		text = "00" + String(Global.fruits)
