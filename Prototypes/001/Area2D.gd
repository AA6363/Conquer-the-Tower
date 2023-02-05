extends Area2D



func _on_Area2D_body_entered(body):
	if not body is Bullet: return
