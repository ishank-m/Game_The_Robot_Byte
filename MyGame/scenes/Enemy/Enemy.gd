extends CharacterBody2D

@export var speed: int = 100
var chase_player = false
var player = null

func _physics_process(_delta):
	if chase_player:
		position += (player.position - position) / speed
		

func _on_detection_area_body_entered(body):
	if body.name == "Player":
		player = body
		chase_player = true


func _on_detection_area_body_exited(body):
	if body.name == "Player":
		player = null
		chase_player = false
