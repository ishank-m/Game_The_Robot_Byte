extends CharacterBody2D
class_name Player
var attack
var attack_diretion
var healing = false
@export var speed: int = 50
@onready var anim = $Player_sprite
var sword = GameState.items["sword"]
var music_playing = false
var walk 
var music = false
var attack_sound = false

func _ready():
	$walk.stream = walk
	$Player_hitbox.add_to_group("Player")
	$attackbox_right.add_to_group("player_attack")
	$attackbox_bottom.add_to_group("player_attack")
	$attackbox_left.add_to_group("player_attack")
	$attackbox_top.add_to_group("player_attack")
	$attackbox_right/CollisionShape2D.disabled = true
	$attackbox_bottom/CollisionShape2D.disabled = true
	$attackbox_left/CollisionShape2D.disabled = true
	$attackbox_top/CollisionShape2D.disabled = true

func _physics_process(_delta):
	if GameState.dialogues_count["worldscene1"]:
		sword =  GameState.items["sword"]
	else:
		sword = null
	if attack and not attack_sound:
		attack_sound = true
		$attack.play()
	elif not attack and attack_sound:
		$attack.stop()
		attack_sound = false
	if GameState.game_state == "play":
		if Input.is_action_just_pressed("health") and not attack and GameState.items["health_potion"]:
			attack = true
			anim.play("health_potion")
			await anim.animation_finished
			GameState.items["health_potion"] -= 1
			GameState.player_health = 120
		elif Input.is_action_just_pressed("invin") and not attack and GameState.items["invin_potion"]:
			attack = true
			anim.play("invin_potion")
			await anim.animation_finished
			GameState.items["invin_potion"] -= 1
			GameState.player_health = 10000
			$Timer.start()
		elif Input.is_action_just_pressed("attack_left") and not attack and sword:
			attack = true
			anim.flip_h = true
			anim.play(sword+"_attack_right")
			$attackbox_left/CollisionShape2D.disabled = false
			await anim.animation_finished
			$attackbox_left/CollisionShape2D.disabled = true
		elif Input.is_action_just_pressed("attack_down") and not attack and sword:
			attack = true
			anim.flip_h = false
			anim.play(sword+"_attack_down")
			$attackbox_bottom/CollisionShape2D.disabled = false
			await anim.animation_finished
			$attackbox_bottom/CollisionShape2D.disabled = true
		elif Input.is_action_just_pressed("attack_right") and not attack and sword:
			attack = true
			anim.flip_h = false
			anim.play(sword+"_attack_right")
			$attackbox_right/CollisionShape2D.disabled = false
			await anim.animation_finished
			$attackbox_right/CollisionShape2D.disabled = true
		elif Input.is_action_just_pressed("attack_up") and not attack and sword:
			attack = true
			anim.flip_h = false
			anim.play(sword+"_attack_up")
			$attackbox_top/CollisionShape2D.disabled = false
			await anim.animation_finished
			$attackbox_top/CollisionShape2D.disabled = true
		elif not attack:
			var direction = Vector2()
			if Input.is_action_pressed("ui_up"):
				direction.y -= 1
			if Input.is_action_pressed("ui_down"):
				direction.y += 1
			if Input.is_action_pressed("ui_left"):
				direction.x -= 1
				if GameState.stairs:
					direction.y += 0.5
				elif GameState.reverse_stairs:
					direction.y -= 0.5
			if Input.is_action_pressed("ui_right"):
				direction.x += 1
				if GameState.stairs:
					direction.y -= 0.5
				elif GameState.reverse_stairs:
					direction.y += 0.5
			if direction.length() > 0:
				direction = direction.normalized()
			velocity = direction*speed
			update_anim(direction)
			move_and_slide()

func update_anim(direction):
	if direction == Vector2(0,0) and not attack:
		anim.stop()
		if music_playing:
			$walk.stop()
			music_playing = false
		return
	else:
		if not music_playing:
			music_playing = true
			$walk.stream = walk
			$walk.play()
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

func _on_player_sprite_animation_finished():
	if attack:
		if $Player_sprite.animation in ["attack_right","attack_up", "attack_down"]:
			attack = false

func stop():
	$walk.stop()


func _on_timer_timeout():
	GameState.player_health = 120
