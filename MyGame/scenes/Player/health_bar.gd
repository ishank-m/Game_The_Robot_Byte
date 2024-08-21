extends CanvasLayer
#need to addd king's health var from global script
@onready var bar = $bar
@onready var critical_health = $critical_health
var anim_playing = false
func _ready():
	$BossHealth.visible = false
	critical_health.visible = false
	bar.visible = true

func _process(_delta):
	if not anim_playing:
		$Health_potion.text = "x"+str(GameState.items["health_potion"])
		$Invin_potion.text = "x"+str(GameState.items["invin_potion"])
		var health = GameState.player_health
		if health > 110:
			bar.frame = 0
		elif health > 100:
			bar.frame = 1
		elif health > 90:
			bar.frame = 2
		elif health > 80:
			bar.frame = 3
		elif health > 70:
			bar.frame = 4
		elif health > 60:
			bar.frame = 5
		elif health > 50:
			bar.frame = 6
		elif health > 40:
			bar.frame = 7
		elif health > 30:
			bar.frame = 8
		elif health > 20:
			bar.frame = 9
		elif health > 10:
			bar.frame = 10
			if not critical_health.visible and not anim_playing:
				bar.visible = false
				critical_health.visible = true
				critical_health.play("default")
				anim_playing = true
	else:
		anim_playing = false
		bar.visible = true
		critical_health.visible = false
		critical_health.stop()
func show_boss_health():
	$BossHealth.visible = true
