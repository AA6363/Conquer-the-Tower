extends Area2D


func _on_HitBox_body_entered(body):
	if body is Player:
		if Global.player_lives <= 0:
			Global.player_lives = 3
			get_tree().reload_current_scene()
		else:
			Global.player_lives -= 1
	if body is Bullet:
		get_parent().queue_free()
		body.queue_free()
