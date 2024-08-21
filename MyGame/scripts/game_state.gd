extends Node
var items = {
	"sword": "wood",
	"health_potion": 0,
	"invin_potion": 0
}
var sword_damage = 9
var kingstate = "damaged"
var player_pos
var player_health = 120
var player_died = false
var current_scene
var game_state = 'main_menu'
var scene = "init"
var current_save
var combat
var points = 0
var no_of_enemies = 0
var spawned_enemies = 0
var pausable = true
var boss_health = 400

var dialogues_count = {
	"downstairs" : 0,
	"lobby1": 0,
	"lobby2": 0,
	"lobby3": 0,
	"lobby4": 0,
	"mcbed": 0,
	"worldscene1" : 0,
	"shop" : 0,
}

var stairs = false
var reverse_stairs = false

var save1 = "res://saves/save1.dat"
var save2 = "res://saves/save2.dat"
var save3 = "res://saves/save3.dat"


func check_save(save):
	if FileAccess.file_exists(save):
		return true

func save_score():
	var file = FileAccess.open(get_current_save(), FileAccess.WRITE)
	current_scene = get_tree().current_scene.scene_file_path
	player_pos = get_tree().current_scene.get_node("Player").position
	file.store_var(items)
	file.store_var(points)
	file.store_var(sword_damage)
	file.store_var(player_health)
	file.store_var(current_scene)
	file.store_var(player_pos)
	file.store_var(game_state)
	file.store_var(scene)
	file.store_var(dialogues_count)
	player_pos = null
	

func load_score():
	if check_save(get_current_save()):
		var file = FileAccess.open(get_current_save(), FileAccess.READ)
		items = file.get_var()
		points = file.get_var()
		sword_damage = file.get_var()
		player_health = file.get_var()
		current_scene = file.get_var()
		player_pos = file.get_var()
		game_state = file.get_var()
		scene = file.get_var()
		dialogues_count = file.get_var()
		get_tree().change_scene_to_file(current_scene)

func get_current_save():
	if current_save == "save1":
		return save1
	elif current_save == "save2":
		return save2
	else:
		return save3

func delete_save():
	if check_save(get_current_save()):
		var dir_access = DirAccess.open("res://saves/")
		dir_access.remove(current_save+".dat")
