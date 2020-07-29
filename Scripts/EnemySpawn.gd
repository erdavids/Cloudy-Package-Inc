extends Node2D

var choices = [
	preload("res://Scenes/Enemies/Enemy-1.tscn"),
	preload("res://Scenes/Enemies/Enemy-2.tscn"),
	preload("res://Scenes/Enemies/Enemy-3.tscn"),
	preload("res://Scenes/Enemies/Enemy-4.tscn"),
	preload("res://Scenes/Enemies/Worst-2.tscn"),
	preload("res://Scenes/Enemies/Worst-Package.tscn"),
	preload("res://Scenes/Packages/Best-Package.tscn"),
	preload("res://Scenes/Packages/Battery-4.tscn"),
	preload("res://Scenes/Packages/Package-1.tscn"),
	preload("res://Scenes/Packages/Package-2.tscn"),
	preload("res://Scenes/Packages/Package-3.tscn"),
	preload("res://Scenes/Packages/Package-4.tscn")
	]
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func start_game():
	randomize()
	$Timer.set_wait_time(1)
	$Timer.start()



func timeout():
	#var enemy = load("res://Scenes/Enemies/Enemy-1.tscn").instance()
	var inst = choices[randi() % choices.size()].instance()

	inst.position.x += rand_range(-300, 300)
	add_child(inst)
