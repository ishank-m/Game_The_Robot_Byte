extends Node2D


func _ready():
	GameState.game_state = "play"

func _process(delta):
	pass

func burn_trees():
	for i in range(1,21):
		var tree = "burning_trees/tree"+str(i)
		get_node(tree).play("default")
func burn_logs():
	for i in range(1,7):
		var log = "burning_logs/log"+str(i)
		get_node(log).play("default")
