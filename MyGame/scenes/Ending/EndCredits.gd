extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()


func _on_timer_timeout():
	print("hi")
	$Camera_animation.play("down")
