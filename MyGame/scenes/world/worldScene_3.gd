extends Node2D
@onready var transition = $TransitionScene
@onready var path_1 = $Path_1/PathFollow2D
@onready var MCPath = $PathMC/PathFollow2D
var anim_playing =false
var door_open = false
var speed: int = 45
var speedKing: int = 30
var is_dialog_playing = false
var once = true
var king_out = false

func _ready():
	GameState.scene = "worldscene4"
	$King.visible = false
	$door.frame = 0
	$Player.visible = false
	$ShopInterface.hide_shop()
	MusicPlayer.stop()
	transition.fade_out()
	transition.connect("fade_in_done", _on_fade_in_done)
	transition.connect("fade_out_done", _on_fade_out_done)
	Dialogic.signal_event.connect(_on_dialogic_signal)
func _process(delta):
	path_1.progress += speedKing*delta
	MCPath.progress += speed*delta
	if not anim_playing and path_1.progress_ratio < 0.45:
		$walk_chars.play()
		$walk_chars2.play()
		$Path_1/PathFollow2D/King.play("up")
		$PathMC/PathFollow2D/MC.play("up")
		anim_playing = true
	elif not anim_playing and path_1.progress_ratio> 0.45 and path_1.progress_ratio< 0.73:
		$Path_1/PathFollow2D/King.flip_h = true
		$Path_1/PathFollow2D/King.play("right")
	elif path_1.progress_ratio > 0.73 and path_1.progress_ratio <1:
		$Path_1/PathFollow2D/King.play("up")
	elif path_1.progress_ratio == 1 and not door_open:
		$door_sound.play()
		$door.play("default")
		$walk_chars2.stop()
		$Path_1/PathFollow2D/King.stop()
		door_open = true
	if MCPath.progress_ratio == 1:
		$walk_chars.stop()
		$PathMC/PathFollow2D/MC.play("down")
		$PathMC/PathFollow2D/MC.stop()
	if path_1.progress_ratio > 0.45 and path_1.progress_ratio < 0.46 and not is_dialog_playing:
		speedKing = 0
		$Path_1/PathFollow2D/King.stop()
		$walk_chars2.stop()
		Dialogic.start("1worlscene3")
		is_dialog_playing = true

func _on_dialogic_signal(argument):
	if argument == "done1":
		$walk_chars2.play()
		speedKing = 30
		anim_playing = false
	elif argument == "done2":
		GameState.game_state = "play"
func _on_fade_out_done():
	GameState.game_state = "pause"

func _on_fade_in_done():
	get_tree().change_scene_to_file("res://scenes/world/WorldScene_4.tscn")

func _on_clouds_animation_finished():
	$CanvasLayer/clouds.hide()

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		transition.fade_in()

func _on_shop_body_entered(body):
	if body.name == "Player":
		GameState.game_state = "pause"
		$Player/Player_sprite.stop()
		$ShopInterface.shop()


func _on_animated_sprite_2d_animation_finished():
	$Path_1/PathFollow2D/King.visible = false
	if $door.animation == "default" and not king_out:
		$door.animation = "close"
		$door.play("close")
		$Timer.start()
		king_out = true
	elif $door.animation == "default" and king_out:
		$door.animation = "close"
		$door.play("close")
	$PathMC/PathFollow2D/MC.visible = false
	$Player.visible = true
	$Player/Player_sprite.play("down")
	$Player/Player_sprite.stop()
	GameState.game_state = "play"


func _on_timer_timeout():
	if $door.animation == "close":
		$door_sound.play()
		$door.play("default")
		await $door.animation_finished
		GameState.kingstate = "normal"
		$King.visible = true
		$King.set_position(Vector2(104,210))
	
	


func _on_dialogue_trigger_body_entered(body):
	if body.name == "Player" and $King.visible and once:
		$Player/Player_sprite.play("up")
		$Player/Player_sprite.stop()
		GameState.game_state = "pause"
		Dialogic.start("2worldscene3")
		once = false
