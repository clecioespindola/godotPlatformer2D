extends Control

var life_size = 32

func on_change_life(_player_health):
	$lifes.rect_size.x = Global.player_health * life_size
