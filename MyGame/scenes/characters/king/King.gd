extends CharacterBody2D

@export var speed = 30
@onready var anim  = $Damaged
@onready var player = get_parent().get_node("Player")

var attacking
var direction
var close_to_player
var animation_playing
var min_distance = 30

func _ready():
	$attackbox_right.add_to_group("king_attack")
	$attackbox_bottom.add_to_group("king_attack")
	$attackbox_left.add_to_group("king_attack")
	$attackbox_top.add_to_group("king_attack")
	$attackbox_right/CollisionShape2D.disabled = true
	$attackbox_bottom/CollisionShape2D.disabled = true
	$attackbox_left/CollisionShape2D.disabled = true
	$attackbox_top/CollisionShape2D.disabled = true

func _physics_process(delta):
	if GameState.kingstate == "damaged":
		anim = $Damaged
		$Normal.visible = false
		$Damaged.visible = true
	else:
		anim = $Normal
		$Damaged.visible = false
		$Normal.visible = true
	if not (animation_playing or GameState.player_died):
		if attacking:
			animation_playing = true
			var x_diff = attacking.position.x - position.x
			var y_diff = attacking.position.y - position.y
			if y_diff >= -32 and y_diff <= 0:
				if x_diff >= -36 and x_diff <= -10:
					anim.flip_h = true
					anim.play("attack_right")
					$attackbox_left/CollisionShape2D.disabled = false
					await anim.animation_finished
					$attackbox_left/CollisionShape2D.disabled = true
				elif x_diff >= 9 and x_diff <= 36:
					anim.flip_h = false
					anim.play("attack_right")
					$attackbox_right/CollisionShape2D.disabled = false
					await anim.animation_finished
					$attackbox_right/CollisionShape2D.disabled = true
				else:
					anim.flip_h = false
					anim.play("attack_up")
					$attackbox_top/CollisionShape2D.disabled = false
					await anim.animation_finished
					$attackbox_top/CollisionShape2D.disabled = true
			elif y_diff >= 0 and y_diff <= 23:
				if x_diff >= -36 and x_diff <= -9:
					anim.flip_h = true
					anim.play("attack_right")
					$attackbox_left/CollisionShape2D.disabled = false
					await anim.animation_finished
					$attackbox_left/CollisionShape2D.disabled = true
				elif x_diff >= 9 and x_diff <= 36:
					anim.flip_h = false
					anim.play("attack_right")
					$attackbox_right/CollisionShape2D.disabled = false
					await anim.animation_finished
					$attackbox_right/CollisionShape2D.disabled = true
				else:
					anim.flip_h = false
					anim.play("attack_down")
					$attackbox_bottom/CollisionShape2D.disabled = false
					await anim.animation_finished
					$attackbox_bottom/CollisionShape2D.disabled = true
		elif not attacking:
			var distance_to_player = position.distance_to(player.position)
			direction = (player.position - position).normalized()
			if distance_to_player >= min_distance:
				velocity = direction * speed
				close_to_player = false
			else:
				velocity = Vector2.ZERO
				close_to_player = true
			king_anim()
			move_and_collide(velocity*delta)
		if close_to_player:
			anim.stop()

func king_anim():
	var x_diff = player.position.x - position.x
	var y_diff = player.position.y - position.y
	if x_diff > 0:
		anim.flip_h = false
		if y_diff > 0:
			anim.play("down_right")
		elif y_diff < 0:
			anim.play("up_right")
		else:
			anim.play("right")
	elif x_diff < 0:
		anim.flip_h = true
		if y_diff > 0:
			anim.play("down_right")
		elif y_diff < 0:
			anim.play("up_right")
		else:
			anim.play("right")
	else:
		anim.flip_h = false
		if y_diff > 0:
			anim.play("down")
		elif y_diff < 0:
			anim.play("up")

func _on_hitbox_body_entered(body):
	if body.is_in_group("Enemy"):
		attacking = body
		attacking.connect("enemy_freed", Callable(self, "_on_enemy_removed"))

func _on_hitbox_body_exited(body):
	if body.is_in_group("Enemy"):
		attacking = null

func _on_enemy_removed():
	attacking = null

func _on_damaged_animation_finished():
	if anim.animation in ["attack_right", "attack_up", "attack_down"]:
		animation_playing = false
