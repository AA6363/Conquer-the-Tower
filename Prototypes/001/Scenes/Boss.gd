extends KinematicBody2D
class_name slimeBoss


enum {SHOOT, JUMP, SLIDE, IDLE}



var state = IDLE
var state_value = RandomNumberGenerator.new()
var state_decided = {
	"SHOOT": 0,
	"JUMP" : 1,
	"SLIDE": 2,
	"IDLE" : 3
}

#match state:
#	SHOOT
#	JUMP
#	SLIDE
#	IDLE


func shoot():
	pass

func jump():
	pass
	
func slide():
	pass

func idle():
	pass
