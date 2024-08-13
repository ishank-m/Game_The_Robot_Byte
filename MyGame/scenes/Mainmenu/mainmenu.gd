extends Control
#Variables
var animation_playing = false
var pressed = false
var press = false
var road_crossing = false
var load_button_state = [
	["selected", "not_selected", "new_game or continue"],
	[0, 4, "new_game"],
	[0, 4, "new_game"],
	[0, 4, "new_game"],
	]
#Initilaizing the Game
func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	$CanvasLayer/ColorRect.visible = false
	if GameState.game_state == "main_menu":
		GameState.game_state = 'main_menu'
		$Player.hide()
		$Bird/Bird_animation.play("birdie")
		$Bird/Timer.start()
		$Car_1_main/AnimationPlayer.play("idle")
		$Truck/truck_anim.play("truck_moving")
	update_load_button_state()

#Play Button on MainMenu
func _on_play_pressed():
	if not animation_playing:
		$Title/Play_button_animation.play("mouse_pressed")
		animation_playing = true
func _on_play_button_animation_animation_finished(anim_name):
	if anim_name == "mouse_pressed":
		animation_playing = false
		$Car_1_main/AnimationPlayer.play("Carmainmenu")
		$Title/Play_Button.frame = 1
		GameState.game_state = 'load_menu'
func _on_play_mouse_entered():
	if not animation_playing:
		$Title/Play_Button.frame = 0
func _on_play_mouse_exited():
	if not animation_playing:
		$Title/Play_Button.frame = 1
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Carmainmenu":
		$Car_1_main/AnimationPlayer.play("idle")
	if anim_name == "Carmainmenu_2":
		Dialogic.start("mainmenu")

#Bird
func _on_timer_timeout():
	$Bird/Bird_animation.play("birdie")

#Quit Button on MainMenu
func _on_quit_pressed():
	if not animation_playing:
		$Title/Quit_button_animation.play("mouse_pressed")
		animation_playing = true
func _on_quit_mouse_entered():
	if not animation_playing:
		$Title/"Quit Button".frame = 0
func _on_quit_mouse_exited():
	if not animation_playing:
		$Title/"Quit Button".frame = 1
func _on_quit_button_animation_animation_finished(anim_name):
	if anim_name == "mouse_pressed":
		animation_playing = false
		get_tree().quit()

#Back Button on LoadMenu
func _on_button_pressed():
	$Loadmenu/Back/backanim.play("back_pressed")
func _on_backanim_animation_finished(anim_name):
	if anim_name == "back_pressed":
		$Car_1_main/AnimationPlayer.play("rev_frm_ld_mn")
		$Loadmenu/Back.frame = 0

#Saved Games load buttons on LoadMenu
func _on_load_1_bt_pressed():
	load_button($Loadmenu/Load_1, 1)
func _on_load_2_bt_pressed():
	load_button($Loadmenu/Load_2, 2)
func _on_load_3_bt_pressed():
	load_button($Loadmenu/Load_3, 3)

#NewGame/Continue button on LoadMenu
func _on_lmbt_1_pressed():
	if not animation_playing and press:
		GameState.load_score()
		$Loadmenu/Lmbutton1/Lmb1.play("circle")
		animation_playing = true
func _on_lmb_1_animation_finished(anim_name):
	if anim_name == "circle":
		animation_playing = false
		$Loadmenu/Lmbutton1.frame = 0
		$Car_1_main/AnimationPlayer.play("Carmainmenu_2")
func _on_lmbt_1_mouse_entered():
	if not animation_playing:
		var load_button_save_no = int(GameState.current_save[GameState.current_save.length() - 1])
		if load_button_state[load_button_save_no][2] == "new_game":
			$Loadmenu/Lmbutton1.frame = 1
		else:
			$Loadmenu/Lmbutton1.frame = 3
func _on_lmbt_1_mouse_exited():
	if not animation_playing:
		var load_button_save_no = int(GameState.current_save[GameState.current_save.length() - 1])
		if load_button_state[load_button_save_no][2] == "new_game":
			$Loadmenu/Lmbutton1.frame = 0
		else:
			$Loadmenu/Lmbutton1.frame = 2

#Delete button on LoadMenu
func _on_lmbt_2_pressed():
	if not animation_playing and press:
		GameState.delete_save()
		update_load_button_state()
		var load_button_save_no = int(GameState.current_save[GameState.current_save.length() - 1])
		if load_button_save_no == 1:
			load_button($Loadmenu/Load_1, 1)
		elif load_button_save_no == 2:
			load_button($Loadmenu/Load_2, 2)
		else:
			load_button($Loadmenu/Load_3, 3)
		$Loadmenu/Lmbutton2/lmb2.play("circle")
		animation_playing = true
func _on_lmb_2_animation_finished(anim_name):
	if anim_name == "circle":
		animation_playing = false
		$Loadmenu/Lmbutton2.frame = 0
func _on_lmbt_2_mouse_entered():
	if not animation_playing:
		$Loadmenu/Lmbutton2.frame = 1
func _on_lmbt_2_mouse_exited():
	if not animation_playing:
		$Loadmenu/Lmbutton2.frame = 0

func _on_trucktimer_timeout():
	if not road_crossing:
		$Truck/truck_anim.play("truck_moving")
		$Car_2/car2_timer.start()
func _on_car_2_timer_timeout():
	if not road_crossing:
		$Car_2/car2_anim.play("car2_moving")

func _on_house_body_entered(body: Node2D):
	if body.name == "Player":
		GameState.game_state = 'pause'
		$Player/Player.play("up")
		$Player/Player.stop()
		$door_open.play("default")

func _on_transition_animation_finished(anim_name):
	if anim_name == "bye":
		get_tree().change_scene_to_file("res://scenes/House/Downstairs.tscn")

func _on_dialogic_signal(argument):
	if argument == "done":
		$Car_1_main.frame = 4
		$Car_2/delay.start()

func _on_delay_timeout():
	$Player.show()
	GameState.game_state = "play"
	road_crossing = true

func _on_door_open_animation_finished():
	$CanvasLayer/ColorRect.visible = true
	$transition.play("bye")

func  load_button(button_node, save_no):
	if button_node.frame == load_button_state[save_no][1]:
		button_node.frame = load_button_state[save_no][0]
		pressed = false
		press = false
		$Loadmenu/Lmbutton1.frame = 0
	elif not pressed:
		button_node.frame = load_button_state[save_no][1]
		pressed = true
		press = true
		GameState.current_save = "save"+str(save_no)
		if load_button_state[save_no][2] == "continue":
			$Loadmenu/Lmbutton1.frame = 2
	if pressed:
		for i in [[$Loadmenu/Load_1,1], [$Loadmenu/Load_2,2] , [$Loadmenu/Load_3,3]]:
			if i[0] != button_node:
				i[0].frame = load_button_state[i[1]][0]
		pressed = false

func update_load_button_state():
	if GameState.check_save(GameState.save1):
		load_button_state[1][2] = "continue"
		load_button_state[1][1] = 7
		load_button_state[1][0] = 3
		$Loadmenu/Load_1.frame = load_button_state[1][0]
	if GameState.check_save(GameState.save2):
		load_button_state[2][2] = "continue"
		load_button_state[2][1] = 6
		load_button_state[2][0] = 2
		$Loadmenu/Load_2.frame = load_button_state[2][0]
	if GameState.check_save(GameState.save3):
		load_button_state[3][2] = "continue"
		load_button_state[3][1] = 5
		load_button_state[3][0] = 1
		$Loadmenu/Load_3.frame = load_button_state[3][0]
