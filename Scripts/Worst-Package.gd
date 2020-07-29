extends RigidBody2D

var can_collide = true

func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
#	if (is_sleeping()):
#		mode = MODE_STATIC
		
	if (position.y > 700):
		
		get_parent().remove_child(self)
		queue_free()


func _on_Worst_body_entered(body):
	
	if (can_collide):
		var bump = load("res://Scenes/bump.tscn").instance()
		add_child(bump)
	
	if ("Enemy" in body.name):
		if (is_instance_valid(body)):
			body.queue_free()
			
			for i in range(0, 3):
				var particles = load("res://Scenes/EnemyParticles.tscn").instance()
				get_parent().get_parent().add_child(particles)
				particles.position = body.position + Vector2(512, -50)
				particles.get_node("Particles2D").emitting = true
			
			var pop = load("res://Scenes/Pop.tscn").instance()
			add_child(pop)
	if ("Package" in body.name):

		body.queue_free()
		
		for i in range(0, 3):
			var particles = load("res://Scenes/PackageParticles.tscn").instance()
			get_parent().get_parent().add_child(particles)
			particles.position = body.position + Vector2(512, -50)
			particles.get_node("Particles2D").emitting = true
		
		var pop = load("res://Scenes/Pop.tscn").instance()
		add_child(pop)
	
	if ("Best" in body.name):

		body.queue_free()
		
		for i in range(0, 3):
			var particles = load("res://Scenes/BestParticles.tscn").instance()
			get_parent().get_parent().add_child(particles)
			particles.position = body.position + Vector2(512, -50)
			particles.get_node("Particles2D").emitting = true
		
		var pop = load("res://Scenes/Pop.tscn").instance()
		add_child(pop)
		
	if ("Battery" in body.name):

		body.queue_free()
		
		for i in range(0, 3):
			var particles = load("res://Scenes/BatteryParticles.tscn").instance()
			get_parent().get_parent().add_child(particles)
			particles.position = body.position + Vector2(512, -50)
			particles.get_node("Particles2D").emitting = true
		
		var pop = load("res://Scenes/Pop.tscn").instance()
		add_child(pop)
			
	can_collide = false
		
	$Timer.set_wait_time(.1)
	$Timer.start()



func _on_Timer_timeout():
	can_collide = true
