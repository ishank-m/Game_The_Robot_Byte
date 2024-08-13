extends Node2D
@onready var incoming = get_node("res://scenes/pauseMenu/input_handle")

func _ready():
	$CanvasLayer.visible = false
	incoming.connect("input_received", _on_input_received())


func _on_input_received():
	print("HI")
func show_menu():
	get_tree().paused = true
	$CanvasLayer.visible = true
	

func hide_menu():
	get_tree().paused = false
	$CanvasLayer.visible = true
