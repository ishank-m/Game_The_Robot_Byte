extends Node2D

@onready var player = get_parent().get_node("Player")
@onready var enemy = preload("res://scenes/Enemy/Enemy.tscn")

var once = false
var enemy_alive = false
var unactive_zone_y = 170
var unactive_zone_x = 86
var player_in_view

func _physics_process(_delta):
	if not (enemy_alive and once):
		if player.position.x:
			once = true
			enemy_alive = true
			var new_enemy = enemy.instantiate()
			new_enemy.position = position
			new_enemy.add_to_group("Enemy")
			get_parent().add_child(new_enemy)
			new_enemy.connect("enemy_freed", Callable(self, "_on_enemy_removed"))

func _on_enemy_removed():
	$respawn_wait_time.start()


func _on_respan_wait_time_timeout():
	once = false
	enemy_alive = false


func _on_player_in_view_body_entered(body):
	if body.name == "Player":
		player_in_view = true


func _on_player_in_view_body_exited(body):
	if body.name == "Player":
		player_in_view = false
