extends CanvasLayer
@onready var anim_player = $Transition
signal fade_out_done
signal fade_in_done
func fade_in():
	anim_player.play("fade_in")

func fade_out():
	anim_player.play("fade_out")


func _on_transition_animation_finished(anim_name):
	if anim_name == "fade_out":
		emit_signal("fade_out_done")
	elif anim_name == "fade_in":
		emit_signal("fade_in_done")
	
