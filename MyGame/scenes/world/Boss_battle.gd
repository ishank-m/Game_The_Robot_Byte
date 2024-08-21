extends Node2D
@onready var transition = $TransitionScene
@onready var path = $Path2D/PathFollow2D
var speed = 50
var anim_playing = false
var go_back = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Player/Player_sprite.flip_h = true
	$Player/Player_sprite.play("right")
	$Player/Player_sprite.stop()
	$Boss.is_attacking = false
	$Boss/Boss_sprite.frame = 0
	$Player.walk = load("res://assets/music/SoundEffects/walk_grass.wav")
	$Player.set_position($Marker2D.position)
	$HealthBar.show_boss_health()
	transition.fade_out()
	transition.connect("fade_in_done", _on_fade_in_done)
	transition.connect("fade_out_done", _on_fade_out_done)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	GameState.scene = "bossbattle"
	GameState.combat = true
func _process(delta):
	path.progress += speed*delta
	if not anim_playing and path.progress_ratio<1:
		$Path2D/PathFollow2D/King.play("walk")
		anim_playing = true
	if path.progress_ratio == 1 and anim_playing:
		$Path2D/PathFollow2D/King.play("attack")
		$Boss/Boss_sprite.play("attack")
		anim_playing =false
	if not anim_playing and go_back:
		print($Path2D/PathFollow2D/King.flip_h)
		$Path2D/PathFollow2D/King.animation = "walk"
		anim_playing = true
	if path.progress_ratio == 0 and go_back:
		$Path2D/PathFollow2D/King.play("down")
		$Path2D/PathFollow2D/King.stop()
		$Player/Player_sprite.play("up")
		$Player/Player_sprite.stop()
		Dialogic.start("bossbattle1")
func _on_fade_out_done():
	pass
func _on_fade_in_done():
	get_tree().change_scene_to_file("res://scenes/world/PalaceEntrance.tscn")
func _on_scene_change_trigger_body_entered(body):
	if body.name == "Player":
		transition.fade_in()

func _on_dialogic_signal(argument):
	if argument == "done1":
		$Path2D/PathFollow2D/King.play("right")
		$Path2D/PathFollow2D/King.stop()
		GameState.game_state = "play"
		$Boss.is_attacking = true

func _on_king_animation_finished():
	if $Path2D/PathFollow2D/King.animation == "attack":
		speed = -30
		go_back = true
		
