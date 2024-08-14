extends CharacterBody2D

@export var speed: int = 10
var chase_player = false
var player = null
var direction = Vector2.ZERO
@onready var anim = $Enemy

func _physics_process(_delta):
	if chase_player:
		direction = (player.position - position).normalized()
		velocity = direction * speed
		move_and_slide()
		enemy_anim()
	else:
		anim.stop()

func _on_detection_area_body_entered(body):
	if body.name == "Player":
		player = body
		chase_player = true


func _on_detection_area_body_exited(body):
	if body.name == "Player":
		player = null
		chase_player = false

func enemy_anim():
	if (player.position.x - position.x) > 5:
		if (player.position.y - position.y) > 5:
			anim.flip_h = true
			anim.play("left_down")
		elif (player.position.y - position.y) < -5:
			anim.flip_h = true
			anim.play("left_up")
		else:
			anim.flip_h = true
			anim.play("left")
	elif (player.position.x - position.x) < -5:
		if (player.position.y - position.y) > 5:
			anim.flip_h = false
			anim.play("left_down")
			
		elif (player.position.y - position.y) < -5:
			anim.flip_h = false
			anim.play("left_up")
		else:
			anim.flip_h = false
			anim.play("left")
	else:
		if (player.position.y - position.y) > 5:
			anim.play("down")
		elif (player.position.y - position.y) < -5:
			anim.play("up")

