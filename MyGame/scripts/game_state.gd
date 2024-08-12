extends Node

var player_pos 
var current_scene
var game_state = 'main_menu'
var scene = "init"
var scene_neww = "init"
var current_save

var lobby1 = 0
var lobby2 = 0
var lobby3 = 0
var lobby4 = 0
var mcbed = 0

var stairs = false

var save1 = "res://saves/save1.save"
var save2 = "res://saves/save2.save"
var save3 = "res://saves/save3.save"

@export var Player: Node2D

func check_save(save):
	if FileAccess.file_exists(save):
		return true

func save_score():
	var file = FileAccess.open(get_current_save(), FileAccess.WRITE)
	current_scene = get_tree().current_scene.scene_file_path
	player_pos = get_tree().current_scene.get_node("Player").position
	file.store_var(current_scene)
	file.store_var(player_pos)
	file.store_var(game_state)
	file.store_var(scene)
	file.store_var(scene_neww)
	file.store_var(lobby1)
	file.store_var(lobby2)
	file.store_var(lobby3)
	file.store_var(lobby4)
	file.store_var(mcbed)
	

func load_score():
	if check_save(get_current_save()):
		var file = FileAccess.open(get_current_save(), FileAccess.READ)
		current_scene = file.get_var()
		player_pos = file.get_var()
		game_state = file.get_var()
		scene = file.get_var()
		scene_neww = file.get_var()
		lobby1 = file.get_var()
		lobby2 = file.get_var()
		lobby3 = file.get_var()
		lobby4 = file.get_var()
		mcbed = file.get_var()
		get_tree().change_scene_to_file(current_scene)

func get_current_save():
	if current_save == "save1":
		return save1
	elif current_save == "save2":
		return save2
	else:
		return save3
