extends KinematicBody2D
class_name slimeBoss

onready var timer = $Timer

enum {SHOOT, JUMP, SLIDE, IDLE}


var state := IDLE
var randomNumber = RandomNumberGenerator.new()
var state_value 
var velocity = Vector2.ZERO
var direction = Vector2.LEFT
var JUMP_FORCE = -350
var FALL_FORCE = 5
var GRAVITY = 5
var HORIZONTAL_SPEED = 400
var HORIZONTAL_JUMP_SPEED = 200
var ready = false

var state_decided = {
	1: SHOOT,
	2: JUMP,
	3: SLIDE,
	4: IDLE
}

func _ready():
	randomNumber.randomize()
	state_value = randomNumber.randi_range(1, 3)
#	state_value = 2
	timer.connect("timeout", self, "_on_timeout")

	

func _physics_process(delta):
	
	
	match state_value:
		1: shoot()
		2: jump()
		3: slide()
#		4: idle()
	velocity = move_and_slide(velocity, Vector2.UP)
	

func _on_timeout():
	state_value = randomNumber.randi_range(1, 3)
	print(state_value)

func shoot():
	pass

func jump():
	var found_wall = is_on_wall()
	if found_wall:
		direction.x *= -1
	velocity.x = direction.x * HORIZONTAL_JUMP_SPEED
	if is_on_floor():
		velocity.y += JUMP_FORCE
		if velocity.y > 0:
			velocity.y += FALL_FORCE
	gravity()
	
func slide():
	var found_wall = is_on_wall()
	if found_wall:
		direction.x *= -1
	velocity.x = direction.x * HORIZONTAL_SPEED
	gravity()
	
	
func idle():
	pass
	

func gravity():
	velocity.y += GRAVITY
	velocity.y = min(velocity.y, 250)
