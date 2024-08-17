extends Node2D
@onready var transition = $TransitionScene
@onready var player = get_node("Player")
var to_where: String
var died = false

func _physics_process(_delta):
	if not died:
		if GameState.player_health == 0:
			var camera = player.get_node("Camera2D")
			player.remove_child(camera)
			get_tree().root.add_child(camera)
			camera.position = player.position
			$Player.queue_free()
			died = true

func _ready():
	transition.fade_out()
	transition.connect("fade_in_done", _on_fade_in_done)
	transition.connect("fade_out_done", _on_fade_out_done)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	$fighting_scene/enemy_dead.visible = false
	$fighting_scene/walk.visible = false
	$King.visible = false
	if GameState.scene == "worldinit":
		$Player.set_position($init.position)
		GameState.scene = "worldscene1"
	elif GameState.scene == "worldscene2":
		$Player.set_position($right.position)
		GameState.scene = "worldscene1"

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		to_where = "world_init"
		transition.fade_in()

func _on_fade_in_done():
	if to_where == "world_init":
		get_tree().change_scene_to_file("res://scenes/world/world_init.tscn")
	elif to_where == "worldscene2":
		get_tree().change_scene_to_file("res://scenes/world/worldScene_2.tscn")
func _on_fade_out_done():
	GameState.game_state = "play"

func _on_to_fight_1_body_entered(body):
	if body.name == "Player":
		to_where = "worldscene2"
		transition.fade_in()


func _on_dialogic_signal(argument):
	if argument == "done1":
		$fighting_scene.play("fight_1")
	elif argument == "done2":
		$fighting_scene/King.visible = false
		$fighting_scene/walk.visible = true
		$fighting_scene.play("walk")
	elif argument == "done3":
		$fighting_scene/walk.frame = 0
		$King.set_position($fighting_scene/walk.position)
		$fighting_scene/walk.visible = false
		$King.visible = true
		$Timer.start()
		await $Timer.timeout
		Dialogic.start("4worldscene_1")
		
	elif argument == "done4":
		GameState.game_state = "play"
	elif argument == "sword":
		pass #add label whch show +1 sword and then delete the label
	elif argument == "done5":
		GameState.game_state = "play"

func _on_dialogue_trigger_body_entered(body):
	if body.name == "Player":
		$Player/Player_sprite.stop()
		GameState.game_state = "pause"
		Dialogic.start("worldScene_1")
		$fighting_scene.play("fight_1")

var count = 0
func _on_fighting_scene_animation_finished(anim_name):
	if anim_name == "fight_1" and count<2:
		$fighting_scene.play("fight_1")
		count += 1
	elif anim_name == "fight_1" and count == 2:
		$fighting_scene.play("fight_2")
	elif anim_name == "fight_2":
		$fighting_scene/enemy_dead.visible = false
		Dialogic.start("2worldscene_1")
	elif anim_name == "walk":
		Dialogic.start("3worldscene_1")
		


func _on_no_go_zone_body_entered(body):
	if body.name == "Player":
		$Player/Player_sprite.stop()
		GameState.game_state = "pause"
		Dialogic.start("5worldscene_1")
