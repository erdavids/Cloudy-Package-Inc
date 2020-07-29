extends Sprite

const VELOCITY: float = 5.0

var g_texture_height: float = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	g_texture_height = texture.get_size().y * scale.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += VELOCITY
	_attempt_reposition()
	
func _attempt_reposition() -> void:
	if position.y > g_texture_height:
		position.y -= 2 * g_texture_height
