extends CanvasLayer
var playing = false
@onready var credits = $credits
var final_pos = Vector2(0, -950)
var speed: int = 40
# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.game_state = "credits"
	MusicPlayer.play_music1()
	$Timer.start()

func _physics_process(delta):
	if playing:
		var direction = (final_pos - credits.position).normalized()
		var distance_to_final = credits.position.distance_to(final_pos)
		if distance_to_final > 1:
			credits.position += direction * speed * delta
		else:
			credits.position = final_pos
			playing = false
			get_tree().change_scene_to_file("res://scenes/Mainmenu/mainmenu.tscn")

func _on_timer_timeout():
	playing = true
	 
