extends CharacterBody2D

const speed = 80

@onready var player = get_parent().get_node("Player")
@onready var anim = $Boss_sprite
@onready var border = get_parent().get_node("border")

var health = 10
var attack = false
var died = false

func _ready():
	$attackarea.add_to_group("boss")
	$attackarea/CollisionShape2D.disabled = true

func _physics_process(delta):
	if not died and is_instance_valid(player):
		if health <= 0:
			died = true
			anim.play("dead")
			border.queue_free()
		var y_diff = position.y - player.position.y
		var direction = Vector2.ZERO
		if not attack:
			if -5 < y_diff and y_diff < 5:
				attack = true
				anim.stop()
				$Timer.start()
			elif y_diff < 0:
				direction.y += 1
			elif y_diff > 0:
				direction.y -= 1
			velocity = direction * speed
			update_anim(direction)
			move_and_collide(velocity*delta)

func update_anim(direction):
	if not attack:
		anim.play("walk")

func _on_boss_sprite_animation_finished():
	if anim.animation == "attack":
		attack = false
	if anim.animation == "dead":
		anim.play("died")

func _on_attackarea_2_area_entered(area):
	if area.is_in_group("Player"):
		GameState.player_health -= 10

func _on_hurtbox_area_entered(area):
	if area.is_in_group("player_attack"):
		health -= GameState.sword_damage

func _on_timer_timeout():
	if not died:
		anim.play("attack")
		$attackarea/CollisionShape2D.disabled = false
		await anim.animation_finished
		$attackarea/CollisionShape2D.disabled = true
