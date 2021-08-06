extends Control

func _ready():
	$controls/startBtn.grab_focus()

func _physics_process(delta: float) -> void:
	if !Global.controllOff:
		$controls/startBtn.grab_focus()
		Global.controllOff = true
		
func _on_startBtn_pressed() -> void:
	get_tree().change_scene("res://Levels/Level_01.tscn")
	
func _on_controlsBtn_pressed() -> void:
	var controlScreen = load("res://Scenes/controlsScreen.tscn").instance()
	get_tree().current_scene.add_child(controlScreen)


func _on_quitBtn_pressed() -> void:
	get_tree().quit()
