extends KinematicBody2D
class_name Player

enum {MOVE, CUTSCENE}

#Sets the player's velocity to zero
var velocity: = Vector2.ZERO
var double_jump:= 1
var state = MOVE

export(Resource) var moveData 
#export(NodePath) onready var camera_funny = get_node(camera_funny) as Camera2D

onready var remoteTransform2D:= $RemoteTransform2D

const BULLET: = preload("res://Scenes/Bullet.tscn")

# warning-ignore:unused_argument
func _physics_process(delta):
	#movement
	
	
	apply_gravity()
	var input:= Vector2.ZERO
	input.x = Input.get_axis("ui_left", "ui_right")
	if state == MOVE:move_state(input)
	elif state == CUTSCENE:cutscene_state()
	
func move_state(input):
	if input.x == 0:
		$AnimatedSprite.animation = "Idle"
		apply_friction()
	else:
		$AnimatedSprite.animation = "Run"
		apply_accelaretion(input.x)
		#Sets Position2D position/manages bullet spawnpoint
		pos2D_positioning(input)
	#jump
	if is_on_floor():

		double_jump =1
		if Input.is_action_just_pressed("jump"):
			jump()
	else:
		$AnimatedSprite.animation = "Jump"
		if Input.is_action_just_released("jump") and velocity.y < moveData.JUMP_FORCE_RELEASE:
			velocity.y = moveData.JUMP_FORCE_RELEASE
		
		#double jump
		if Input.is_action_just_pressed("jump") and double_jump > 0:
			double_jump()
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
		bullet_spawnpoint_position(bullet)
	reload_scene()
func cutscene_state():
	pass

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
#plays sound and reloads screen when the player dies
func player_die():
	AudioPlayer.play_sound(AudioPlayer.HURT)
	queue_free()
	Events.emit_signal("player_died")
	#get_tree().reload_current_scene()

func connect_camera(camera):

	var camera_path = camera.get_path()
	remoteTransform2D.remote_path = camera_path
	pass

func jump():
	velocity.y = moveData.JUMP_FORCE
	AudioPlayer.play_sound(AudioPlayer.JUMP)

func double_jump():
	velocity.y = moveData.JUMP_FORCE
	double_jump -= 1

func reload_scene():
	if Input.is_action_just_pressed("player_respawn"):
		get_tree().reload_current_scene()

func pos2D_positioning(input):
	if input.x > 0: 
		$AnimatedSprite.flip_h = false
		$Position2D.position.x = 35
	elif input.x < 0:
		$AnimatedSprite.flip_h = true
		$Position2D.position.x = -35

func bullet_spawnpoint_position(bullet):
	if sign($Position2D.position.x) == 1:
		bullet.set_direction(1)
	else:
		bullet.set_direction(-1)
	get_parent().add_child(bullet)
	bullet.global_position = $Position2D.global_position

func _on_VisibilityNotifier2D_screen_exited():
	Events.emit_signal("player_left_camera")

