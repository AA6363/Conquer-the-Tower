extends Node

var number_of_bullets = 5
var player_lives = 3

func _process(delta):
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	elif Input.is_action_just_pressed("exit"):
		get_tree().quit()
