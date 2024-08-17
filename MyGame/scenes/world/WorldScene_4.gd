extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.game_state = "play"
# Called every frame. 'delta' is the elapsed time since the previous frame.
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
