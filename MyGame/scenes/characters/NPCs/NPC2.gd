extends CharacterBody2D

var ini_pos = Vector2(20, 140)
var final_pos = Vector2(135, 140)
var speed: int = 30
var which = "right"
var stop_threshold: float = 1.0
var is_moving = true

func _ready():
	$NPC2.position = ini_pos
	$NPC2.animation = "right"

func _process(delta):
	if is_moving:
		if which == "right":
			$NPC2.flip_h = false
			$NPC2.play("right")
			var direction = (final_pos - $NPC2.position).normalized()
			var distance_to_final = $NPC2.position.distance_to(final_pos)

			if distance_to_final > stop_threshold:
				$NPC2.position += direction * speed * delta
			else:
				$NPC2.position = final_pos
				$NPC2.stop()
				is_moving = false
				$cooldown.start()
		else:
			$NPC2.flip_h = true
			$NPC2.play("right")
			var direction = (ini_pos - $NPC2.position).normalized()
			var distance_to_final = $NPC2.position.distance_to(ini_pos)

			if distance_to_final > stop_threshold:
				$NPC2.position += direction * speed * delta
			else:
				$NPC2.position = ini_pos
				$NPC2.stop()
				is_moving = false
				$cooldown.start()

func _on_cooldown_timeout():
	is_moving = true
	if which == "right":
		which = "left"
	else:
		which = "right"
