extends Node

signal input_received

func _ready():
	set_process(true)



func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		emit_signal("input_received")
