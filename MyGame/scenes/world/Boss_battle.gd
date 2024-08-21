extends Node2D
@onready var transition = $TransitionScene
@onready var path = $Path2D/PathFollow2D
var speed = 40
var anim_playing = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Boss.is_attacking = false
	$Boss/Boss_sprite.frame = 0
	$Player.walk = load("res://assets/music/SoundEffects/walk_grass.wav")
	$Player.set_position($Marker2D.position)
	$HealthBar.show_boss_health()
	transition.fade_out()
	transition.connect("fade_in_done", _on_fade_in_done)
	transition.connect("fade_out_done", _on_fade_out_done)
	GameState.scene = "bossbattle"
	GameState.combat = true
func _process(delta):
	path.progress += speed*delta
	if not anim_playing:
		$Path2D/PathFollow2D/King.play("walk")
		anim_playing = true
	if path.progress_ratio == 1 and :
		
func _on_fade_out_done():
	GameState.game_state = "play"
func _on_fade_in_done():
	get_tree().change_scene_to_file("res://scenes/world/PalaceEntrance.tscn")
func _on_scene_change_trigger_body_entered(body):
	if body.name == "Player":
		transition.fade_in()
