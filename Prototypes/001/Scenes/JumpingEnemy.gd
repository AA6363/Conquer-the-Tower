extends KinematicBody2D
class_name jumpingEnemey

var velocity = Vector2.ZERO
var direction = Vector2.LEFT
var JUMP_FORCE = -500
var FALL_FORCE = 0
var GRAVITY = 3
var HORIZONTAL_SPEED = 150


func _physics_process(delta):
#	print(velocity.y)
	
	velocity.x = direction.x * HORIZONTAL_SPEED
	move_and_slide(velocity, Vector2.UP)
	if is_on_wall():
		direction.x *= -1
	jump()
	fall_force()
	apply_gravity()

func apply_gravity():
	velocity.y += GRAVITY
	velocity.y = min(velocity.y, 250)

func fall_force():
	if velocity.y > 0:
		velocity.y += FALL_FORCE
		FALL_FORCE = move_toward(FALL_FORCE, 500, 2)

func jump():
	if is_on_floor():
		FALL_FORCE = 0
		velocity.y += JUMP_FORCE
