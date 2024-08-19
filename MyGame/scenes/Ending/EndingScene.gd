extends Node2D
@onready var transition = $TransitionScene

func _ready():
	$TransitionScene.visible = false
	$Player.visible = false
	$"player incoming".visible = true
	$"player incoming".play("appear")
	transition.connect("fade_in_done", _on_fade_in_done)
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_fade_in_done():
	get_tree().change_scene_to_file("res://scenes/Ending/EndCredits.tscn")

func _process(delta):
	pass
func _on_dialogic_signal():
	pass


func _on_player_incoming_animation_finished():
	$Player.visible = true
	$"player incoming".visible = false
	GameState.game_state = "play"


func _on_stairs_1_body_entered(body):
	if body.name == "Player":
		transition.fade_in()


func _on_stairs_2_body_entered(body):
	if body.name == "Player":
		transition.fade_in()


func _on_out_body_entered(body):
	if body.name == "Player":
		transition.fade_in()
