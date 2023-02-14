extends Node2D

onready var camera:= $Node
onready var player:= $Player
onready var CheckPoint:= $CheckPoint

var player_spawn_location = Vector2.ZERO
var new_dialog

const PlayerScene = preload("res://Scenes/Player.tscn")

func _ready():
	print("loaded", " ", Global.player_checkp_position)
	VisualServer.set_default_clear_color(Color.darkslategray)
	player.position = Global.player_checkp_position
	camera.position = Global.camera_position
	Events.connect("player_died", self, "_on_player_died")
	Events.connect("dialogue_start",self, "_on_dialogue_start")
	new_dialog = Dialogic.start('Def_First')
	new_dialog.connect("dialogic_signal",self,"dialog_listener")
	


func _on_player_died():
	get_tree().reload_current_scene()

func _on_dialogue_start():
	add_child(new_dialog)

func dialog_listener(string):
	match string:
		"asd":
			Events.emit_signal("dialog_ends")
			print("heya!")
