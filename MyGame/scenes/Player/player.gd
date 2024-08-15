extends CharacterBody2D
class_name Player
var attack
var attack_diretion
@export var speed: int = 50
@onready var anim = $Player_sprite

func _ready():
	$attackbox_right.add_to_group("player_attack")
	$attackbox_right/CollisionShape2D.disabled = true

func _physics_process(_delta):
	if Input.is_action_just_pressed("attack"):
		attack = true
		anim.play("attack")
		$attackbox_right/CollisionShape2D.disabled = false
		await anim.animation_finished
		$attackbox_right/CollisionShape2D.disabled = true
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
		if Input.is_action_pressed("ui_right"):
			direction.x += 1
			if GameState.stairs:
				direction.y -= 0.5
		if direction.length() > 0:
			direction = direction.normalized()
		velocity = direction*speed
		update_anim(direction)
		move_and_slide()

func update_anim(direction):
	if direction == Vector2(0,0) and not attack:
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


func _on_player_sprite_animation_finished():
	if attack:
		attack = false
