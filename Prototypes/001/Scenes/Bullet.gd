extends KinematicBody2D
class_name Bullet

const SPEED:= 400

var velocity:= Vector2()
var direction = 1

func set_direction(dir):
	direction = dir
	if dir == -1:
		$Sprite.flip_h = true

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	pass

func _on_VisibilityNotifier2D_screen_exited():
	Global.number_of_bullets +=1
	queue_free()
	
	
