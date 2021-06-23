extends Control

export (int) var minutes = 0
export (int) var seconds = 0

func _process(_delta: float) -> void:
	if minutes > 0 and seconds <=0:
		minutes -= 1
		seconds = 59
	
	if seconds >= 10:
		$seconds.set_text(":" + str(seconds))
	else:
		$seconds.set_text(":0" + str(seconds))

	if minutes >= 10:
		$minutes.set_text(str(minutes))
	else:
		$minutes.set_text("0" + str(minutes))
		
	if seconds <= 0:
		$Timer.stop()
#		yield(get_tree().create_timer(1),"timeout")
		if get_tree().reload_current_scene() != OK:
			print("Algo deu errado!")
		

func _on_Timer_timeout() -> void:
	seconds -= 1
