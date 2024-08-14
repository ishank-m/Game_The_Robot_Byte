extends Node2D
@onready var save_button = $CanvasLayer/Buttons/save
@onready var quit_button = $CanvasLayer/Buttons/quit
var animation_playing = false

func _ready():
	save_button.frame = 1
	set_process_input(PROCESS_MODE_ALWAYS)
	$CanvasLayer.layer = 999
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
	


func _on_save_button_pressed():
	if not animation_playing:
		$CanvasLayer/Buttons/save/save_animation.play("circle")
		animation_playing = true
	


func _on_save_button_mouse_entered():
	if not animation_playing:
		save_button.frame = 0


func _on_save_button_mouse_exited():
	if not animation_playing:
		save_button.frame = 1


#func _on_save_animation_finished():
	
	
