extends StaticBody2D


onready var pos2D = $Position2D

const BULLET = preload("res://Scenes/EnemeyProjectlie.tscn")

func _ready():
	pass 
	var bullet = BULLET.instance()






func _on_Timer_timeout():
	pass
