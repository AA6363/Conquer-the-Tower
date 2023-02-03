extends KinematicBody2D
class_name slimeBoss


enum {SHOOT, JUMP, SLIDE, IDLE}



var state := IDLE
var randomNumber = RandomNumberGenerator.new()
var state_value 
var state_decided = {
	0: SHOOT,
	1: JUMP,
	2: SLIDE,
	3: IDLE
}

func _ready():
	randomNumber.randomize()
	state_value = randomNumber.randi_range(0, 3)

func _physics_process(delta):
	
	
	if state_value == 0:
		state = SHOOT


func shoot():
	pass

func jump():
	pass
	
func slide():
	pass

func idle():
	pass
	
