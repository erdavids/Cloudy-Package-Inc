extends RigidBody2D

var speed = 250
var velocity = Vector2(0, 200)


var can_collide = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	if (is_sleeping()):
		mode = MODE_STATIC
		
	if (position.y > 700):
		
		get_parent().remove_child(self)
		queue_free()

func destroy():
	var part = load("res://Scenes/BestParticles.tscn").instance()
	part.get_node("Particles2D").emitting = true
	
	get_parent().add_child(part)
	
	part.position = self.position
	
	get_parent().remove_child(self)
	queue_free()
		


func _on_Package_body_entered(body):
	var bump = load("res://Scenes/bump.tscn").instance()
	add_child(bump)
	
	can_collide = false
		
	$Timer.set_wait_time(.1)
	$Timer.start()


func _on_Timer_timeout():
	can_collide = true

