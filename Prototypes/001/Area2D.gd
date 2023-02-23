extends Area2D

onready var player = $"../Player"
onready var camera = $"../Node"

func _on_Area2D_body_entered(body):
	if body is Bullet:
		Global.player_checkp_position = player.position
		Global.camera_position = camera.position
		body.queue_free()



