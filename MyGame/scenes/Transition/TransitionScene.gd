extends CanvasLayer
@onready var anim_player = $Transition
signal fade_in_done

func fade_in():
	visible = true
	anim_player.play("fade_in")

func fade_out():
	visible = true
	anim_player.play("fade_out")


func _on_transition_animation_finished(anim_name):
	if anim_name == "fade_out":
		visible = false
		GameState.game_state = "play"
	elif anim_name == "fade_in":
		emit_signal("fade_in_done")
	
