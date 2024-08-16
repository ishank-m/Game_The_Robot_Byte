extends CanvasLayer

@onready var bar = $bar
@onready var critical_health = $critical_health

func _ready():
	critical_health.visible = false
	bar.visible = true

func _process(_delta):
	var health = GameState.player_health
	if health > 100:
		bar.frame = 0
	elif health > 80:
		bar.frame = 1
	elif health > 60:
		bar.frame = 2
	elif health > 40:
		bar.frame = 3
	elif health > 20:
		bar.frame = 4
		critical_health.visible = false
	elif health > 0:
		bar.frame = 5
		if not critical_health.visible:
			print("hi")
			bar.visible = false
			critical_health.visible = true
			critical_health.play("default")
