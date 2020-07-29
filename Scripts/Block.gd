extends Node2D

var falling_speed = 50

var display = "UNKNOWN"

var type = "BLOCK"

func _ready():
	display = "W"
	
func _process(delta):
	position.y += falling_speed * delta
	
