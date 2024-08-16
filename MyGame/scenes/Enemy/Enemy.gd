extends CharacterBody2D

@export var speed: int = 40
var chase_player = false
var min_distance = 10
var player = null
var player_in_hitbox = false
var attack = false
var attack_cooldown = true
var animation_playing = false
var health = 60
var direction = Vector2.ZERO
@onready var anim = $Enemy_sprite

func _physics_process(delta):
	if health <= 0:
		queue_free()
		return

	if not animation_playing:
		if chase_player:
			direction = (player.position - position).normalized()
			var distance_to_player = position.distance_to(player.position)
			if distance_to_player > min_distance:
				velocity = direction * speed
			else:
				velocity = Vector2.ZERO
			move_and_collide(velocity * delta)
			enemy_anim()
		else:
			anim.stop()
	elif attack and not animation_playing:
		animation_playing = true
		attack_cooldown = false
		attack_anim()

func _on_detection_area_body_entered(body):
	if body.name == "Player":
		player = body
		chase_player = true

func _on_detection_area_body_exited(body):
	if body.name == "Player":
		player = null
		chase_player = false

func enemy_anim():
	var x_diff = player.position.x - position.x
	var y_diff = player.position.y - position.y
	
	if x_diff > 5:
		anim.flip_h = true
		if y_diff > 5:
			anim.play("left_down")
		elif y_diff < -5:
			anim.play("left_up")
		else:
			anim.play("left")
	elif x_diff < -5:
		anim.flip_h = false
		if y_diff > 5:
			anim.play("left_down")
		elif y_diff < -5:
			anim.play("left_up")
		else:
			anim.play("left")
	else:
		if y_diff > 5:
			anim.play("down")
		elif y_diff < -5:
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

func attack_anim():
	var x_diff = player.position.x - position.x
	var y_diff = player.position.y - position.y
	
	if y_diff >= -32 and y_diff <= -5:
		if x_diff >= -36 and x_diff <= -10:
			anim.flip_h = false
			anim.play("attack_left")
		elif x_diff >= 9 and x_diff <= 36:
			anim.flip_h = true
			anim.play("attack_left")
		else:
			anim.flip_h = false
			anim.play("attack_up")
		print("Playing attack animation based on y_diff")
	elif y_diff >= 6 and y_diff <= 23:
		if x_diff >= -36 and x_diff <= 10:
			anim.flip_h = false
			anim.play("attack_left")
		elif x_diff >= 9 and x_diff <= 36:
			anim.flip_h = true
			anim.play("attack_left")
		else:
			anim.flip_h = false
			anim.play("attack_down")
		print("Playing attack animation based on y_diff")
	else:
		print("No valid attack animation")

func _on_hitbox_enemy_area_entered(area):
	if area.is_in_group("player_attack"):
		health -= 20

func _on_attack_cooldown_timeout():
	if player_in_hitbox and not animation_playing:
		attack_anim()

func _on_enemy_sprite_animation_finished():
	if anim.animation in ["attack_up", "attack_down", "attack_left"]:
		if player_in_hitbox:
			GameState.player_health -= 10  # Assuming GameState is handling player health
		attack = false
		animation_playing = false
		attack_cooldown = true
		print("Animation finished, resetting attack and cooldown")
