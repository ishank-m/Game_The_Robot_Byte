extends Node2D

@onready var enemy = preload("res://scenes/Enemy/Enemy.tscn")

var once = false
var enemy_alive = false


func _physics_process(_delta):
	if not (enemy_alive and once):
		once = true
		enemy_alive = true
		var new_enemy = enemy.instantiate()
		new_enemy.position = position
		get_parent().add_child(new_enemy)
		new_enemy.connect("enemy_freed", Callable(self, "_on_enemy_removed"))

func _on_enemy_removed():
	$respawn_wait_time.start()


func _on_respan_wait_time_timeout():
	once = false
	enemy_alive = false
