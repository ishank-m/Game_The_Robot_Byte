extends Node2D
@onready var transition = $TransitionScene

# Called when the node enters the scene tree for the first time.
func _ready():
	transition.fade_out()
	transition.connect("fade_out_done", _on_fade_out_done)
	transition.connect("fade_in_done", _on_fade_in_done)
	$Label.text = "hi"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_fade_in_done():
	get_tree().change_scene_to_file("res://scenes/test/b.tscn")
func _on_fade_out_done():
	transition.visible = false


func _on_button_pressed():
	transition.visible = true
	transition.fade_in()
