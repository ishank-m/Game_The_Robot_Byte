extends Node2D
var entered = false
var enter2 = false
var enter3 = false

func _ready():
	GameState.game_state = 'play'
	if GameState.scene == "downstairs":
		$Player.set_position($down.position)
		GameState.scene = "lobby"
	elif GameState.scene == 'mc_bedroom':
		$Player.set_position($mc_bedroom.position)
		GameState.scene = "lobby"
	elif GameState.scene == "room_2":
		$Player.set_position($room_2.position)
		GameState.scene = "lobby"

func _process(_delta):
	if entered:
		get_tree().change_scene_to_file("res://scenes/House/Downstairs.tscn")
	if enter2:
		get_tree().change_scene_to_file("res://scenes/House/wardroom.tscn")
	if enter3:
		get_tree().change_scene_to_file("res://scenes/House/MCbedroom.tscn")

func _on_downstairs_body_entered(body: Node2D):
	if body.name == "Player":
		GameState.game_state = "wait"
		entered = true

func _on_wdoor_body_entered(body: Node2D):
	if body.name == "Player":
		GameState.game_state = "wait"
		$Door/AnimationPlayer.play("door")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "door":
		enter2 = true

func _on_bedroom_body_entered(body: Node2D):
	if body.name == "Player":
		GameState.game_state = "wait"
		enter3 = true

func _on_stairs_body_entered(body):
	if body.name == "Player":
		GameState.stairs = true
		

func _on_stairs_body_exited(body):
	if body.name == "Player":
		GameState.stairs = false
