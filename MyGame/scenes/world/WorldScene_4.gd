extends Node2D
@onready var transition = $TransitionScene
@onready var player = get_node("Player")

func _ready():
	GameState.player_died = false
	GameState.player_health = 120
	$dead.visible = false
	$Player.walk = load("res://assets/music/SoundEffects/walk_grass.wav")
	MusicPlayer.music_final_fight()
	transition.fade_out()
	transition.connect("fade_out_done", _on_fade_out_done)
	transition.connect("fade_in_done", _on_fade_in_done)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	animations_play()
	$Player.set_position($Marker2D.position)
	$Player/Player_sprite.flip_h = true
	$Player/Player_sprite.play("right")
	$Player/Player_sprite.stop()

func  _physics_process(_delta):
	if not GameState.player_died:
		if GameState.player_health == 0:
			GameState.player_died = true
			$dead.set_position(player.position) 
			var camera = player.get_node("Camera2D")
			player.remove_child(camera)
			get_tree().root.add_child(camera)
			camera.position = player.position
			$Player.queue_free()
			$dead.visible = true
			GameState.spawn = false
			Dialogic.start("dead")

func _on_fade_out_done():
	GameState.game_state = "play"

func _on_fade_in_done():
	get_tree().change_scene_to_file("res://scenes/world/Boss_battle.tscn")

func _on_dialogic_signal(argument):
	if argument == "done1":
		GameState.game_state = "play"
	if argument == "dead":
		$dead.visible = true
		GameState.spawn = false
		get_tree().change_scene_to_file("res://scenes/world/worldScene_2.tscn")
func animations_play():
	for i in range(1,14):
		var fight = "fight"+str(i)
		fight = get_node(fight)
		fight.get_node("robot").play("fight")
		fight.get_node("soldier").play("fight")

func _on_dialogue_trigger_body_entered(body):
	if body.name == "Player":
		GameState.game_state = "pause"
		$Player/Player_sprite.stop()
		Dialogic.start("1worldscene4")

func _on_scene_change_trigger_body_entered(body):
	if body.name == "Player":
		transition.fade_in()
