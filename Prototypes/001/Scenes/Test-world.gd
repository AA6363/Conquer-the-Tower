extends Node2D

onready var camera:= $Node
onready var player:= $Player
var player_spawn_location = Vector2.ZERO

const PlayerScene = preload("res://Scenes/Player.tscn")

func _ready():
	VisualServer.set_default_clear_color(Color.darkslategray)
#	player.connect_camera(camera)
	player_spawn_location = player.global_position
	Events.connect("player_died", self, "_on_player_died")
	

	


func _on_player_died():
	var player = PlayerScene.instance()
	add_child(player)
	player.position = Vector2(224 , 383)
	Events.emit_signal("new_player_spawn", player)
#	get_tree().reload_current_scene()


