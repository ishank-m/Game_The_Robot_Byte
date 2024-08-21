extends CharacterBody2D

const speed = 80

@onready var anim = $Boss_sprite

var attack = false

func _physics_process(_delta):
	var direction = Vector2()
	if not attack:
		if Input.is_action_just_pressed("attack"):
			attack = true
			anim.play("attack")
		elif Input.is_action_pressed("ui_up"):
			direction.y -= 1
		elif Input.is_action_pressed("ui_down"):
			direction.y += 1
		elif Input.is_action_pressed("ui_left"):
			direction.x -= 1
		elif Input.is_action_pressed("ui_right"):
			direction.x += 1
		elif direction.length() > 0:
			direction = direction.normalized()
		velocity = direction*speed
		update_anim(direction)
		move_and_slide()

func update_anim(direction):
	if direction == Vector2(0,0) and not attack:
		anim.stop()
		return
	elif not attack:
		anim.play("walk")


func _on_boss_sprite_animation_finished():
	if anim.animation == "attack":
		attack = false
