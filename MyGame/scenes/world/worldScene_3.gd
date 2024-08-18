extends Node2D
@onready var transition = $TransitionScene

func _ready():
	$ShopInterface.visible = false
	transition.fade_out()
	transition.connect("fade_in_done", _on_fade_in_done)
	transition.connect("fade_out_done", _on_fade_out_done)
	$Player.set_position($init.position)

func _on_fade_out_done():
	GameState.game_state = "play"

func _on_fade_in_done():
	get_tree().change_scene_to_file("res://scenes/world/worldScene_2.tscn")

func _on_clouds_animation_finished():
	$CanvasLayer/clouds.hide()

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		transition.fade_in()

func _on_shop_body_entered(body):
	if body.name == "Player":
		GameState.game_state = "pause"
		$Player/Player_sprite.stop()
		$ShopInterface.visible = true
