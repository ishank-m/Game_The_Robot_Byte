extends Node2D
@onready var path = $Path2D/PathFollow2D
var speed = 40
func _process(delta):
	path.progress += speed*delta

func _ready():
	var curve = Curve2D.new()
	
	# Add points to the curve
	curve.add_point($Player.position)  # Start point
	curve.add_point(Vector2(150, 50)) # First segment
	curve.add_point(Vector2(150, 150))
	$Path2D.curve = curve
