extends Node2D

@onready var path = $Path2D/PathFollow2D
@onready var player = $Player
@onready var follower = $Path2D/PathFollow2D
@onready var anim = $Player/Player_sprite

var speed = 40
var follow = false
var anim_playing = false
var prev_position = Vector2.ZERO

func _ready():
	GameState.game_state = "play"
	prev_position = follower.position

func _process(delta):
	if follow:
		path.progress += speed * delta
		prev_position = follower.position
	if not anim_playing:
		update_animation()

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

var direction = Vector2(follower.position - Vector2(150,50))
func update_animation():
	if direction == Vector2(0,0):
		anim.stop()
		return
	if direction.x > 0:
		if direction.y > 0:
			anim.flip_h = false
			anim.play("down_right")
		elif direction.y < 0:
			anim.flip_h = false
			anim.play("up_right")
		else:
			anim.flip_h = false
			anim.play("right")
	elif direction.x < 0:
		if direction.y > 0:
			anim.flip_h = true
			anim.play("down_right")
			
		elif direction.y < 0:
			anim.flip_h = true
			anim.play("up_right")
		else:
			anim.flip_h = true
			anim.play("right")
	else:
		if direction.y > 0:
			anim.play("down")
		elif direction.y < 0:
			anim.play("up")
