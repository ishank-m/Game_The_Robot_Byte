extends CanvasLayer
var playing = false
@onready var credits = $credits
var final_pos = Vector2(0, 645)
var speed: int = 30
# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.game_state = "play"
	$Timer.start()

func _physics_process(delta):
	if playing:
		var direction = (credits.position - final_pos).normalized()
		var distance_to_final = credits.position.distance_to(final_pos)
		if distance_to_final > 1:
			credits.position += direction * speed * delta
		else:
			credits.position = final_pos
			playing = false

func _on_timer_timeout():
	print("hi")
	playing = true
	 
