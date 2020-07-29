extends KinematicBody2D


var speed = 300
var friction = 0.15
var acceleration = 0.2
var velocity = Vector2.ZERO

export var push = 5

var STATE = "CATCH"

var rotate = true

func _ready():
	$AnimatedSprite.play("default")
	
	$BatteryTimer.set_wait_time(2)
	$BatteryTimer.start()

func lerpp(A, B, F):
	return B + (A - B) * F

func _physics_process(delta):
	var input_velocity = Vector2.ZERO
	
	if (get_parent().game_over == false):
		if Input.is_action_pressed("ui_right"):
			input_velocity.x += 1
			
			if (rotate):
				rotation_degrees = lerpp(rotation_degrees, 20, .8)
		if Input.is_action_pressed("ui_left"):
			input_velocity.x -= 1
			if (rotate):
				rotation_degrees = lerpp(rotation_degrees, -20, .8)
		if Input.is_action_pressed("ui_down"):
			input_velocity.y += 1
		if Input.is_action_pressed("ui_up"):
			input_velocity.y -= 1
			
		if Input.is_action_pressed("Switch"):
			speed = 700
			rotate = true
		elif Input.is_action_pressed("Slow"):
			speed = 200
			rotation_degrees = lerpp(rotation_degrees, 0, .8)
			rotate = false
		else:
			rotate = true
			speed = 400
	else:
		input_velocity.y += 1
		
	input_velocity = input_velocity.normalized() * speed
	

	if input_velocity.length() > 0:
		velocity = velocity.linear_interpolate(input_velocity, acceleration)
	else:
		velocity = velocity.linear_interpolate(Vector2.ZERO, friction)
	
	if (input_velocity.x == 0):
		rotation_degrees = lerpp(rotation_degrees, 0, .8)


	if (STATE == "CATCH"):
		velocity = move_and_slide(velocity)
		
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if ("Battery" in collision.collider.name):
				get_parent().battery += .05
		
	else:
		velocity = move_and_slide(velocity, Vector2.UP, false, 4, PI/4, false)
	
		
	if (STATE == "DESTROY"):
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if ("Enemy" in collision.collider.name):
				if (is_instance_valid(collision.collider)):
					collision.collider.queue_free()

					for i in range(0, 2):
						var particles = load("res://Scenes/EnemyParticles.tscn").instance()
						get_parent().add_child(particles)
						particles.position = collision.collider.position + Vector2(512, -50)
						particles.get_node("Particles2D").emitting = true
					
					var pop = load("res://Scenes/Pop.tscn").instance()
					add_child(pop)
			elif ("Package" in collision.collider.name):

					collision.collider.queue_free()
					
					for i in range(0, 2):
						var particles = load("res://Scenes/PackageParticles.tscn").instance()
						get_parent().add_child(particles)
						particles.position = collision.collider.position + Vector2(512, -50)
						particles.get_node("Particles2D").emitting = true
					
					var pop = load("res://Scenes/Pop.tscn").instance()
					add_child(pop)
			
			elif ("Worst" in collision.collider.name):

					collision.collider.queue_free()
					for i in range(0, 2):
						var particles = load("res://Scenes/WorstParticles.tscn").instance()
						get_parent().add_child(particles)
						particles.position = collision.collider.position + Vector2(512, -50)
						particles.get_node("Particles2D").emitting = true
					
					var pop = load("res://Scenes/Pop.tscn").instance()
					add_child(pop)
					
			elif ("Best" in collision.collider.name):

					collision.collider.queue_free()
					for i in range(0, 2):
						var particles = load("res://Scenes/BestParticles.tscn").instance()
						get_parent().add_child(particles)
						particles.position = collision.collider.position + Vector2(512, -50)
						particles.get_node("Particles2D").emitting = true
					
					var pop = load("res://Scenes/Pop.tscn").instance()
					add_child(pop)
					
			elif ("Battery" in collision.collider.name):
					get_parent().battery += 20
					collision.collider.queue_free()
					for i in range(0, 2):
						var particles = load("res://Scenes/BatteryParticles.tscn").instance()
						get_parent().add_child(particles)
						particles.position = collision.collider.position + Vector2(512, -50)
						particles.get_node("Particles2D").emitting = true
					
					var pop = load("res://Scenes/Pop.tscn").instance()
					add_child(pop)
					
	if (position.x > 1060):
		position.x = -50
	elif (position.x < -50):
		position.x = 1050
		
	if (position.y > 650):
		position.y = -50
	elif (position.y < -50):
		position.y = 650


func switch():
	if (STATE == "CATCH"):
		STATE = "DESTROY"
		$AnimatedSprite.stop()
		$AnimatedSprite.play("attack")
	else:
		STATE = "CATCH"
		$AnimatedSprite.stop()
		$AnimatedSprite.play("default")

func timeout():
	var sp = load("res://Scenes/Speech.tscn").instance()
	sp.position.y -= 80
	add_child(sp)
	
func game_started():
	$Timer.set_wait_time(20)
	$Timer.start()
	
func game_over():
	$Timer.stop()
	$AnimatedSprite.stop()
	$AnimatedSprite.play("dead")


func _on_BatteryTimer_timeout():
	if (get_parent().game_started):
		get_parent().battery -= 2
