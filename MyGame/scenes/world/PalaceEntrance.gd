extends Node2D

var start_scene = false
var door_open = false
@onready var kingPath = $KingPath/PathFollow2D
@onready var MCPath = $MCPath/PathFollow2D
@onready var transition = $TransitionScene
var speed = 50
var anim_playing = false
var scene_change = false

func _ready():
	transition.fade_out()
	transition.connect("fade_in_done", _on_fade_in_done)
	$castle.frame = 0

func _process(delta):
	kingPath.progress += speed*delta
	MCPath.progress += speed*delta
	if not anim_playing:
		$KingPath/PathFollow2D/King.play("up")
		$MCPath/PathFollow2D/MC.play("up")
		anim_playing = true
	if kingPath.progress_ratio > 0.4 and not door_open:
		$castle.play("gates_open")
		door_open = false
	if kingPath.progress_ratio == 1 and not scene_change:
		scene_change = true
		transition.fade_in()

func _on_fade_in_done():
	get_tree().change_scene_to_file("res://scenes/world/ThroneRoom.tscn")

func _on_castle_animation_finished():
	$castle.frame = 3

func follow_path():
	if not anim_playing:
		kingPath.progress += speed * get_process_delta_time()
