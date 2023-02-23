extends KinematicBody2D

const SPEED = 500

var velocity = Vector2.ZERO
var direction = 1

func set_direction():
	if direction == 1:
		$Sprite.flip_h = true
		
func _physics_process(delta):
	pass
	velocity.x = direction * delta * SPEED

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
