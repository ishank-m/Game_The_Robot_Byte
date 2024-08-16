extends CharacterBody2D

var ini_pos = Vector2(288, 76)
var final_pos = Vector2(166, 76)
var speed: int = 30
var which = "left"
var stop_threshold: float = 1.0
var is_moving = true

func _ready():
	$NPC3.flip_h = true
	$NPC3.position = ini_pos
	$NPC3.animation = "left"

func _process(delta):
	if is_moving:
		if which == "left":
			$NPC3.flip_h = true
			$NPC3.play("left")
			var direction = (final_pos - $NPC3.position).normalized()
			var distance_to_final = $NPC3.position.distance_to(final_pos)

			if distance_to_final > stop_threshold:
				$NPC3.position += direction * speed * delta
			else:
				$NPC3.position = final_pos
				$NPC3.stop()
				is_moving = false
				$cooldown.start()
		else:
			$NPC3.flip_h = false
			$NPC3.play("left")
			var direction = (ini_pos - $NPC3.position).normalized()
			var distance_to_final = $NPC3.position.distance_to(ini_pos)

			if distance_to_final > stop_threshold:
				$NPC3.position += direction * speed * delta
			else:
				$NPC3.position = ini_pos
				$NPC3.stop()
				is_moving = false
				$cooldown.start()

func _on_cooldown_timeout():
	is_moving = true
	if which == "left":
		which = "right"
	else:
		which = "left"
