extends Node2D


# Called when the node enters the scene tree for the first time.
func _process(_delta):
	if GameState.game_state == 'pause':
		$AnimationPlayer.play("in")


# Called every frame. 'delta' is the elapsed time since the previous frame.

