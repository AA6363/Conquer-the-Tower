extends Area2D

onready var player = $"../Player"

func _on_Area2D_body_entered(body):
	if body is Bullet:
		Global.player_checkp_position = player.position
		Events.emit_signal("bullet_hit_check_point")
#		print("player position: ",player.position)
		

