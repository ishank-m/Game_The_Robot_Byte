extends CharacterBody2D

var ini_pos = Vector2(152, 13)
var final_pos = Vector2(152, 130)
var speed: int = 30
var which = "down"
var stop_threshold: float = 1.0
var is_moving = true

func _ready():
	$NPC1.position = ini_pos
	$NPC1.animation = "down"

func _process(delta):
	if is_moving:
		if which == "down":
			$NPC1.play("down")
			var direction = (final_pos - $NPC1.position).normalized()
			var distance_to_final = $NPC1.position.distance_to(final_pos)

			if distance_to_final > stop_threshold:
				$NPC1.position += direction * speed * delta
			else:
				$NPC1.position = final_pos
				$NPC1.stop()
				is_moving = false
				$cooldown.start()
		else:
			$NPC1.play("up")
			var direction = (ini_pos - $NPC1.position).normalized()
			var distance_to_final = $NPC1.position.distance_to(ini_pos)

			if distance_to_final > stop_threshold:
				$NPC1.position += direction * speed * delta
			else:
				$NPC1.position = ini_pos
				$NPC1.stop()
				is_moving = false
				$cooldown.start()

func _on_cooldown_timeout():
	is_moving = true
	if which == "down":
		which = "up"
	else:
		which = "down"
