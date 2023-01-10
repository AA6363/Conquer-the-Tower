extends KinematicBody2D

var velocity = Vector2.ZERO

export(int) var JUMP_FORCE = -120
export(int) var FALL_FORCE = 2
export(int) var JUMP_FORCE_RELEASE = -30
export(int) var ACCELERATION = 20
export(int) var MAX_SPEED = 50
export(int) var FRICTION = 5
export(int) var GRAVITY = 5


func _physics_process(delta):
	#movement
	apply_gravity()
	var input:= Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	
	if input.x == 0:
		apply_friction()
		$AnimatedSprite.play("Idle")
	else:
		apply_accelaretion(input.x)
		
	
	#jump
	if is_on_floor():

		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_FORCE
	else:
			if Input.is_action_just_released("jump") and velocity.y < JUMP_FORCE_RELEASE:
				velocity.y = JUMP_FORCE_RELEASE
		
	if velocity.y > 0:
		velocity.y += FALL_FORCE

		
	#removes the leftover velocity
	velocity = move_and_slide(velocity, Vector2.UP)
#simply applies gravity	
func apply_gravity():
	velocity.y += GRAVITY
#velocity.x is going towards 0, which slows and later stops the player
func apply_friction():
	velocity.x = move_toward(velocity.x, 0, FRICTION)
#Speeds up the player to 50, the max value
func apply_accelaretion(amount):
	velocity.x = move_toward(velocity.x, amount * MAX_SPEED , ACCELERATION)

