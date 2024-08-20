extends CharacterBody2D

const speed = 30

@onready var anim = $soldier
@onready var destination = get_parent().get_node("destination")
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

var animation_playing = false
var attack = false

func _ready():
	add_to_group("soldier")
	$attack_area/CollisionShape2D.visible = false

func _physics_process(_delta):
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	if attack and not animation_playing:
		animation_playing = true
		velocity = Vector2.ZERO
		anim.play("attack_left")
	else:
		velocity = dir * speed
		anim.play("left")
	move_and_slide()

func makepath():
	nav_agent.target_position = Vector2(destination.position.x, position.y)

func _on_path_timer_timeout():
	makepath()

func _on_detection_box_body_entered(body):
	if body.is_in_group("Enemy"):
		attack = body
		#attack.connect("enemy_freed", Callable(self, "_on_enemy_removed"))

func _on_enemy_removed():
	attack = null

func _on_soldier_animation_finished():
	if anim.animation == "attack_left":
		animation_playing = false
