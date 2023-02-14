extends KinematicBody2D
class_name slimeBoss

onready var timer = $Timer

enum {FIGHT, CUTSCENE}


var state := FIGHT
var randomNumber = RandomNumberGenerator.new()
var state_value 
var velocity = Vector2.ZERO
var direction = Vector2.LEFT
var JUMP_FORCE = -350
var FALL_FORCE
var GRAVITY = 5
var HORIZONTAL_SPEED = 350
var HORIZONTAL_JUMP_SPEED = 200

#var state_decided = {
#	1: SHOOT,
#	2: JUMP,
#	3: SLIDE,
#	4: IDLE
#}

func _ready():
	randomNumber.randomize()
	state_value = randomNumber.randi_range(1, 3)
#	state_value = 2
	timer.connect("timeout", self, "_on_timeout")
	Events.connect("dialogue_start", self, "_on_dialogue_start")
	Events.connect("dialog_ends",self, "_on_dialog_ends")

func _physics_process(delta):
	
	
	
	if state == FIGHT: pick_move()
	if state == CUTSCENE: cutscene_state()
	
func _on_timeout():
	state_value = randomNumber.randi_range(1, 3)

func shoot():
	gravity()

func jump():
	var found_wall = is_on_wall()
	if found_wall:
		direction.x *= -1
	velocity.x = direction.x * HORIZONTAL_JUMP_SPEED
	if is_on_floor():
		FALL_FORCE = 0
		velocity.y += JUMP_FORCE
		if velocity.y < 0:
			velocity.y += FALL_FORCE
			FALL_FORCE = move_toward(FALL_FORCE , 500 , 50)
	gravity()
	
func slide():
	var found_wall = is_on_wall()
	if found_wall:
		direction.x *= -1
	velocity.x = direction.x * HORIZONTAL_SPEED
	gravity()
	
	
func idle():
	gravity()
	

func gravity():
	velocity.y += GRAVITY
	velocity.y = min(velocity.y, 250)

func pick_move():
	match state_value:
		1: shoot()
		2: jump()
		3: slide()
		4: idle()
	velocity = move_and_slide(velocity, Vector2.UP)
#	print(state_value)

func _on_dialogue_start():
	state = CUTSCENE
	
func cutscene_state():
	state_value = 4
	timer.stop()

func _on_dialog_ends():
	timer.start()
	print("time_should be working now!")
	state = FIGHT
