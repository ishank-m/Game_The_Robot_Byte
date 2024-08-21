extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.game_state = "play"
	GameState.combat = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
