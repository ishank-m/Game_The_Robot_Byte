extends Node2D
@onready var transition = $TransitionScene

func _ready():
	transition.fade_out()
	transition.connect("fade_out_done", _on_fade_out_done)
	transition.connect("fade_in_done", _on_fade_in_done)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	animations_play()
	$Player.set_position($Marker2D.position)
	$Player/Player_sprite.flip_h = true
	$Player/Player_sprite.play("right")
	$Player/Player_sprite.stop()

func _on_fade_out_done():
	GameState.game_state = "play"
func _on_fade_in_done():
	pass
func _process(_delta):
	pass
func _on_dialogic_signal(argument):
	if argument == "done1":
		GameState.game_state = "play"
func animations_play():
	for i in range(1,14):
		var fight = "fight"+str(i)
		fight = get_node(fight)
		fight.get_node("robot").play("fight")
		fight.get_node("soldier").play("fight")
		


func _on_dialogue_trigger_body_entered(body):
	if body.name == "Player":
		GameState.game_state = "pause"
		$Player/Player_sprite.stop()
		Dialogic.start("1worldscene4")
