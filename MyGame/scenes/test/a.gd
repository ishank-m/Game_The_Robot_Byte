extends Node2D
@onready var path = $Path2D/PathFollow2D
var speed = 40
var follow = false
@onready var player = $Player
@onready var follower = $Path2D/PathFollow2D

func _process(delta):
	if follow:
		path.progress += speed*delta
		print($Path2D/PathFollow2D.position)
func _ready():
	GameState.game_state= "play"


func _on_button_pressed():
	follower.position = player.position
	player.get_parent().remove_child(player)
	follower.add_child(player)
	player.position = Vector2.ZERO
	follow_now()
	follow = true
	
func follow_now():
	var curve = Curve2D.new()
	curve.add_point(follower.position)
	curve.add_point(Vector2(150, 50))
	$Path2D.curve = curve
