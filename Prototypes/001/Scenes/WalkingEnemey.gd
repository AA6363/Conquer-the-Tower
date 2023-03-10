extends KinematicBody2D
class_name walkingEnemey

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

onready var ledgeCheckRight:= $LedgeCheckRight
onready var ledgeCheckLeft:= $LedgeCheckLeft

func _physics_process(delta):
	var found_wall = is_on_wall()
	var found_ledge = not ledgeCheckRight.is_colliding() or not ledgeCheckLeft.is_colliding()
	
	
	if found_wall or found_ledge:
		direction *= -1
	
	velocity = direction * 50
	move_and_slide(velocity, Vector2.UP)
