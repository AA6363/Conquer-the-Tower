extends StaticBody2D


onready var pos2D = $Position2D
var projectile

const PROJECTILE = preload("res://Scenes/EnemeyProjectlie.tscn")

func _ready():
	projectile = PROJECTILE.instance() 
	
func _on_Timer_timeout():
	
	set_direction()
	get_parent().add_child(projectile)
	projectile.global_position = pos2D.global_position

func set_direction():
	if pos2D.global_position.x > 0:
		projectile.set_direction(-1)
