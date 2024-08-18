extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.game_state = "pause"
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.start("inpalace1")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_dialogic_signal(argument):
	if argument == "done1":
		GameState.game_state = "play"
