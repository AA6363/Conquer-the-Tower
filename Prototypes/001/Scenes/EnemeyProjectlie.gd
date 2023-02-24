extends KinematicBody2D
class_name Projectile

const SPEED = 500

var velocity = Vector2.ZERO
var direction = 1

func set_direction(dir):
	direction = dir
	if direction == 1:
		$Sprite.flip_h = true
		
func _physics_process(delta):
	pass
	velocity.x = direction * delta * SPEED
	translate(velocity)

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
