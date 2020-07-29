extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass



func _on_AudioStreamPlayer2D_finished():
	get_parent().remove_child(self)
	queue_free()
