extends Node2D
@onready var save_button = $CanvasLayer/Buttons/save
@onready var quit_button = $CanvasLayer/Buttons/quit
var animation_playing = false

func _ready():
	save_button.frame = 1
	quit_button.frame = 1
	set_process_input(PROCESS_MODE_ALWAYS)
	set_process_mode(PROCESS_MODE_ALWAYS)
	$CanvasLayer.layer = 999
	$CanvasLayer.visible = false

func show_menu():
	get_tree().paused = true
	$CanvasLayer.visible = true

func hide_menu():
	get_tree().paused = false
	$CanvasLayer.visible = false

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel") and get_tree().paused:
		hide_menu()
	elif Input.is_action_just_pressed("ui_cancel") and not get_tree().paused:
		show_menu()

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
func _on_save_animation_animation_finished(anim_name):
	if anim_name == "circle":
		animation_playing = false
		$CanvasLayer/Buttons/save.frame = 7
		GameState.save_score()



func _on_quit_button_pressed():
		if not animation_playing:
			$CanvasLayer/Buttons/quit/quit_animation.play("circle")
			animation_playing = true
func _on_quit_button_mouse_entered():
	if not animation_playing:
		quit_button.frame = 0
func _on_quit_button_mouse_exited():
	if not animation_playing:
		quit_button.frame = 1
func _on_quit_animation_animation_finished(anim_name):
	if anim_name == "circle":
		animation_playing = false
		#GameState.game_state = "main_menu"
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/Mainmenu/mainmenu.tscn")


func reset():
	save_button.frame = 1
	quit_button.frame = 1
