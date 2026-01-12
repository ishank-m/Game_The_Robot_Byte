extends Node2D
@onready var transition = $TransitionScene
@onready var path = $Path2D/PathFollow2D
@onready var player = get_node("Player")
@onready var camera = $Player/Camera2D
var speed = 50
var anim_playing = false
var go_back = false
var died = false
var is_walking = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if GameState.player_died:
		camera.make_current()
		GameState.player_died = false
		GameState.player_health = 120
	GameState.player_died = false
	GameState.player_health = 120
	$dead.visible = false
	$King.visible = false
	$Player/Player_sprite.flip_h = true
	$Player/Player_sprite.play("right")
	$Player/Player_sprite.stop()
	$Boss.is_attacking = false
	$Boss/Boss_sprite.frame = 0
	$Player.walk = load("res://assets/music/SoundEffects/walk_grass.wav")
	$Player.set_position($Marker2D.position)
	$Player/Player_sprite.stop()
	GameState.game_state = "pause"
	$HealthBar.show_boss_health()
	transition.fade_out()
	transition.connect("fade_in_done", _on_fade_in_done)
	transition.connect("fade_out_done", _on_fade_out_done)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	GameState.scene = "bossbattle"
	GameState.combat = true

func _physics_process(_delta):
	if not GameState.player_died:
		if GameState.player_health == 0:
			GameState.player_died = true
			$dead.visible = true
			$dead.set_position(player.position)
			camera = player.get_node("Camera2D")
			player.remove_child(camera)
			get_tree().root.add_child(camera)
			var cam = get_tree().root.get_node("Camera2D")
			cam.position = player.position
			$Player.queue_free()
			MusicPlayer.stop()
			Dialogic.start("dead")

func _process(delta):
	if not is_walking:
		$walk.play()
		is_walking = true
	path.progress += speed*delta
	if not anim_playing and path.progress_ratio<1:
		$Path2D/PathFollow2D/King.play("walk")
		anim_playing = true
	if path.progress_ratio == 1 and anim_playing:
		$Path2D/PathFollow2D/King.play("attack")
		$Boss/Boss_sprite.play("attack")
		$kingattack.play()
		$attack.play()
		anim_playing =false
		is_walking = false
	if not anim_playing and go_back:
		if not is_walking:
			$walk.play()
			is_walking = true
		$Path2D/PathFollow2D/King.animation = "walk"
		anim_playing = true
	if path.progress_ratio == 0 and go_back:
		$walk.stop()
		$Path2D/PathFollow2D/King.play("down")
		$Path2D/PathFollow2D/King.stop()
		$Player/Player_sprite.play("up")
		$Player/Player_sprite.stop()
		Dialogic.start("bossbattle1")
		$HealthBar.visible = false
		go_back = false
	if $Boss.died and not died:
		$HealthBar.hide_boss_health()
		Dialogic.start("bossbattle2")
		died = true
func _on_fade_out_done():
	GameState.game_state = "pause"
func _on_fade_in_done():
	get_tree().change_scene_to_file("res://scenes/world/PalaceEntrance.tscn")
func _on_scene_change_trigger_body_entered(body):
	if body.name == "Player":
		transition.fade_in()

func _on_dialogic_signal(argument):
	if argument == "done1":
		$Path2D/PathFollow2D/King.play("walk")
		$Path2D/PathFollow2D/King.stop()
		GameState.game_state = "play"
		$Boss.is_attacking = true
		$HealthBar.visible = true
	elif argument == "done2":
		$Path2D/PathFollow2D/King.visible = false
		$King.visible = true
	elif argument == "dead":
		GameState.boss_health = 600
		get_tree().change_scene_to_file("res://scenes/world/Boss_battle.tscn")
func _on_king_animation_finished():
	if $Path2D/PathFollow2D/King.animation == "attack":
		speed = -30
		go_back = true
		$kingattack.stop()
		
