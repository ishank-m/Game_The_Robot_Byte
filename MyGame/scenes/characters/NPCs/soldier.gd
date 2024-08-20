extends CharacterBody2D

const speed = 30

@onready var destination = get_parent().get_node("destination")
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

func _ready():
	pass

func _physics_process(_delta):
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()

func makepath():
	nav_agent.target_position = Vector2(destination.position.x, position.y)

func _on_path_timer_timeout():
	makepath()
