extends CharacterBody2D

@export var speed: int = 40
var chase_player = false
var min_distance = 10
var player = null
var player_in_hitbox = false
var attack = false
var attack_cooldown = true
var health = 60
var direction = Vector2.ZERO
@onready var anim = $Enemy

func _physics_process(delta):
	if not attack:
		if chase_player:
			direction = (player.position - position).normalized()
			var distance_to_player = position.distance_to(player.position)
			if distance_to_player > min_distance:
				velocity = direction * speed
			else:
				velocity = Vector2.ZERO
			move_and_collide(velocity*delta)
			enemy_anim()
		else:
			anim.stop()
	else:
		if attack_cooldown:
			$attack_cooldown.start()
			attack_cooldown = false
	if health == 0:
		queue_free()

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

func _on_hitbox_enemy_body_entered(body):
	if body.name == "Player":
		attack = true
		player_in_hitbox = true
		chase_player = false

func _on_hitbox_enemy_body_exited(body):
	if body.name == "Player":
		player_in_hitbox = false
		chase_player = true

func _on_attack_cooldown_timeout():
	attack_cooldown = true
	if player:
		if (player.position.y - position.y) in range(-5,-21):
			if (player.position.x - position.x) in range(-36, -10):
				anim.flip_h = false
				anim.play("attack_left")
			elif (player.position.x - position.x) in range(9,36):
				anim.flip_h = true
				anim.play("attack_left")
			else:
				anim.flip_h = false
				anim.play("attack_up")
		if (player.position.y - position.y) in range(6, 23):
			if (player.position.x - position.x) in range(-36, -10):
				anim.flip_h = false
				anim.play("attack_left")
			elif (player.position.x - position.x) in range(9,36):
				anim.flip_h = true
				anim.play("attack_left")
			else:
				anim.flip_h = false
				anim.play("attack_down")

func _on_enemy_animation_finished():
	if $Enemy.animation == "attack_left":
		if player_in_hitbox:
			GameState.player_health -= 10
		else:
			attack = false


func _on_hitbox_enemy_area_entered(area):
	if area.is_in_group("player_attack"):
		health -= 20
