extends Node2D
@onready var transition = $TransitionScene
@onready var path_1 = $Path_1/PathFollow2D
@onready var path_2 = $Path_2/PathFollow2D
@onready var MCPath = $PathMC/PathFollow2D
var anim_playing =false
var scene = 1
var speed: int = 50
var dialog = false

func _ready():
	$Player.visible = false
	$Path_2.visible = false
	$ShopInterface.hide_shop()
	MusicPlayer.stop()
	transition.fade_out()
	transition.connect("fade_in_done", _on_fade_in_done)
	transition.connect("fade_out_done", _on_fade_out_done)
func _process(delta):
	path_1.progress += speed*delta
	MCPath.progress += speed*delta
	if not anim_playing:
		$Path_1/PathFollow2D/King.play("up")
		$PathMC/PathFollow2D/MC.play("up")
		anim_playing = true
	if MCPath.progress_ratio == 1:
		$PathMC/PathFollow2D/MC.play("down")
		$PathMC/PathFollow2D/MC.stop()
	if path_1.progress_ratio == 1 and not dialog:
		$Path_1/PathFollow2D/King.stop()
		dialog = true
		
	if dialog and path_1.progress_ratio == 1 and MCPath.progress_ratio == 1:
		Dialogic.start("1worlscene3")
		dialog = false


func _on_fade_out_done():
	GameState.game_state = "play"

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


func _on_dialogue_trigger_body_entered(body):
	if body.name == "Player":
		GameState.game_state = "pause"
		print($King.position)
