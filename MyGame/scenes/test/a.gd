extends Node2D
@onready var transition = $TransitionScene

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.game_state = "play"
	$Label.text = "hi"


func _on_button_pressed():
	transition.visible = true
	transition.fade_in()
