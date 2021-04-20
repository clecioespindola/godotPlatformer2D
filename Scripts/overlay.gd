extends ColorRect

var progress = 0.0

func _process(_delta: float) -> void:
	material.set("shader_param/progress", progress)
