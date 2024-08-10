extends Node2D

func _ready():
	GameState.game_state = 'wait'
	if GameState.scene == "lobby":
		$Player.set_position($door_pos.position)
		GameState.scene  = "mc_bedroom"

func _on_timer_timeout():
	GameState.game_state = 'play'


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		$door.play("open")


func _on_door_animation_finished():
	GameState.scene = "mc_bedroom"
	get_tree().change_scene_to_file("res://scenes/House/Lobby.tscn")
