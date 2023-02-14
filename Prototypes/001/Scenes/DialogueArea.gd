extends Area2D

#func _ready():
#	var new_dialog = Dialogic.start("Def_First","Def_First","res://Scenes/Dialogue_test_scene.tscn", false)
#	add_child(new_dialog)
func _on_DialogueArea_body_entered(body):
	if body is Player:
		Events.emit_signal("dialogue_start")
		print("asd")
		queue_free()
