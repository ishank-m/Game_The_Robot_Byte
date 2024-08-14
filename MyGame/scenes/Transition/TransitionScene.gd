extends CanvasLayer
@onready var anim_player = $Transition
signal finished

func fade_in():
	anim_player.play("fade_in")

func fade_out():
	anim_player.play("fade_out")


func _on_transition_animation_finished(_anim_name):
	emit_signal("finished")
	
