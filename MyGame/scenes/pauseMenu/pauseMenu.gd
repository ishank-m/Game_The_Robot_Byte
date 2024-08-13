extends Node2D

func _ready():
	set_process_input(PROCESS_MODE_ALWAYS)
	$CanvasLayer.visible = false

func show_menu():
	get_tree().paused = true
	$CanvasLayer.visible = true

func hide_menu():
	get_tree().paused = false
	$CanvasLayer.visible = false

func _input(event):
	if event.is_action_pressed("ui_cancel") and not get_tree().paused:
		show_menu()
	elif event.is_action_pressed("ui_cancel") and get_tree().paused:
		hide_menu()
	
