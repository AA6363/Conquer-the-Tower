extends Camera2D

onready var player =$"../Player"
var camera_position = Vector2.ZERO


func _ready():
	Events.connect("player_left_camera", self, "_on_player_left_camera")
	Events.connect("new_player_spawn", self, "_on_new_player_spawn")


func _on_player_left_camera():
	if not is_instance_valid(player):
		return
	else:
		print(player.position.x, " ", position.x)
		if player.position.x < position.x:
			position.x -= 1024
		else:
			position.x += 1024
		print(position.x) 

func _on_new_player_spawn(new_player):
	yield(get_tree().create_timer(0.1),"timeout")
	position.x = 514
	player = new_player
	print(player)
	
