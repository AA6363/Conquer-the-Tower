extends KinematicBody2D
class_name Player

#Sets the player's velocity to zero
var velocity: = Vector2.ZERO
var double_jump:= 1


export(Resource) var moveData 

const BULLET: = preload("res://Scenes/Bullet.tscn")

func _physics_process(delta):
	#movement
	
	
	apply_gravity()
	var input:= Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if input.x == 0:
		$AnimatedSprite.animation = "Idle"
		apply_friction()
	else:
		$AnimatedSprite.animation = "Run"
		apply_accelaretion(input.x)
		#Sets Position2D position/manages bullet spawnpoint
		if input.x > 0: 
			$AnimatedSprite.flip_h = false
			$Position2D.position.x = 35

		elif input.x < 0:
			$AnimatedSprite.flip_h = true
			$Position2D.position.x = -35

		
	
	#jump
	if is_on_floor():

		double_jump =1
		if Input.is_action_just_pressed("jump"):
			velocity.y = moveData.JUMP_FORCE
	else:
		$AnimatedSprite.animation = "Jump"
		if Input.is_action_just_released("jump") and velocity.y < moveData.JUMP_FORCE_RELEASE:
			velocity.y = moveData.JUMP_FORCE_RELEASE
		
		#double jump
		if Input.is_action_just_pressed("jump") and double_jump > 0:
			velocity.y = moveData.JUMP_FORCE
			double_jump -= 1
		if velocity.y > 0:
			velocity.y += moveData.FALL_FORCE

	var was_in_air: = not is_on_floor()
	#removes the leftover velocity
	velocity = move_and_slide(velocity, Vector2.UP)
	var just_landed:= is_on_floor() and was_in_air
	if just_landed:
		$AnimatedSprite.animation = "Run"
		$AnimatedSprite.frame = 1
		#Shooting/bullet spawning
	if Input.is_action_just_pressed("shoot") and Global.number_of_bullets > 0:
		var bullet = BULLET.instance()
		Global.number_of_bullets -=1
		if sign($Position2D.position.x) == 1:
			bullet.set_direction(1)
		else:
			bullet.set_direction(-1)
		get_parent().add_child(bullet)
		bullet.global_position = $Position2D.global_position
	
#simply applies gravity	
func apply_gravity():
	velocity.y += moveData.GRAVITY
	velocity.y = min(velocity.y, 250)
#velocity.x is going towards 0, which slows and later stops the player
func apply_friction():
	velocity.x = move_toward(velocity.x, 0, moveData.FRICTION)
#Speeds up the player to 50, the max value
func apply_accelaretion(amount):
	velocity.x = move_toward(velocity.x, amount * moveData.MAX_SPEED , moveData.ACCELERATION)
