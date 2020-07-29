extends Node2D

var choices = [
	"Something isn't right...",
	"Uh-oh...",
	"I can feel something...",
	"I don't feel so good",
	"My circuits..."
]

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$Label.text = choices[randi() % choices.size()]
	
	$Timer.set_wait_time(5)
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation_degrees = -get_parent().rotation_degrees


func timeout():
	get_parent().switch()
	
	get_parent().remove_child(self)
	queue_free()
