extends Area2D

func _ready():
	Events.connect("dialog_ends",self, "_on_dialog_end")

func _on_DialogueArea_body_entered(body):
	if body is Player:
		Events.emit_signal("dialogue_start")
#		print("asd")


func _on_dialog_end():
	queue_free()
