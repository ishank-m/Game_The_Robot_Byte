extends Node2D
var once = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$castle.frame = 0
	GameState.game_state = "play"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_door_open_body_entered(body):
	if not once:
		if body.name == "Player":
			$Player/Player_sprite.play("up")
			$Player/Player_sprite.stop()
			GameState.game_state = "pause"
			$castle.play("gates_open")


func _on_scene_change_trigger_body_entered(body):
	if body.name == "Player":
		GameState.game_state = "pause"
		print("hi")


func _on_castle_animation_finished():
	once = true
	$castle.frame = 3
	GameState.game_state = "play"
