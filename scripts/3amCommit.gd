extends Sprite2D

const T = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation += 2*PI/5 * delta 
	if rotation > 2*PI:
		rotation -= 2*PI
