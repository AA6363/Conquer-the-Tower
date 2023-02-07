extends Node

var number_of_bullets = 5
var player_lives = 3
var player_checkp_position = Vector2(224 , 383)
#var player_checkp_position = Vector2(1788, 448)

var camera_position = Vector2(514, 300)
#var camera_position = Vector2(1770, 300)



func _process(delta):
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	elif Input.is_action_just_pressed("exit"):
		get_tree().quit()

func _ready():
	Events.connect("bullet_hit_check_point", self, "_on_check_point_hit")
#
func _on_check_point_hit(): 
	print(player_checkp_position)
