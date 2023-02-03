extends Node

const HURT = 	preload("res://soundbits/player_hrt.wav")
const ENEHURT = preload("res://soundbits/enemy_hrt.wav")
const JUMP = 	preload("res://soundbits/jump.wav")

onready var audioPlayer:= $AudioPlayer

func play_sound(sound):
	for audioStreamPlayer in audioPlayer.get_children():
		if not audioStreamPlayer.playing:
			audioStreamPlayer.stream = sound
			audioStreamPlayer.play()
			break
