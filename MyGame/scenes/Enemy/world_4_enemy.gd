extends CharacterBody2D

const speed = 30

@onready var anim = $enemy
@onready var destination = get_parent().get_node("destination_robot")
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

var animation_playing = false
var attack = false

func _ready():
	add_to_group("Enemy")
	$attack_area/CollisionShape2D.visible = false

func _physics_process(_delta):
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	if attack and (not animation_playing):
		animation_playing = true
		velocity = Vector2.ZERO
		anim.play("attack_right")
	else:
		velocity = dir * speed
		anim.play("right")
	move_and_slide()

func makepath():
	nav_agent.target_position = Vector2(destination.position.x, position.y)

func _on_detection_box_body_entered(body):
	if body.is_in_group("soilder") or body.name == "Player" or body.name == "King":
		attack = body

func _on_enemy_animation_finished():
	if anim.animation == "attack_left":
		animation_playing = false
 
func _on_timer_timeout():
	makepath()
