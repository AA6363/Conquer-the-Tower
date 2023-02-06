extends Node2D

onready var camera:= $Node
onready var player:= $Player
onready var CheckPoint:= $CheckPoint

var player_spawn_location = Vector2.ZERO

const PlayerScene = preload("res://Scenes/Player.tscn")

func _ready():
	print("loaded", " ", Global.player_checkp_position)
	VisualServer.set_default_clear_color(Color.darkslategray)
	player.position = Global.player_checkp_position
	camera.position = Global.camera_position
	Events.connect("player_died", self, "_on_player_died")
	


func _on_player_died():
	get_tree().reload_current_scene()


