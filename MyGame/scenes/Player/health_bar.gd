extends CanvasLayer
#need to addd king's health var from global script
@onready var bar = $bar
@onready var critical_health = $critical_health
@onready var boss =$BossHealth
var anim_playing = false
func _ready():
	$Boss.visible = false
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
	else:
		anim_playing = false
		bar.visible = true
		critical_health.visible = false
		critical_health.stop()
	if boss.visible:
		if GameState.boss_health>360:
			boss.frame = 0
		elif GameState.boss_health> 320:
			boss.frame = 1
		elif GameState.boss_health> 280:
			boss.frame = 2
		elif GameState.boss_health> 240:
			boss.frame = 3
		elif GameState.boss_health> 200:
			boss.frame = 4
		elif GameState.boss_health> 160:
			boss.frame = 5
		elif GameState.boss_health> 120:
			boss.frame = 6
		elif GameState.boss_health> 80:
			boss.frame = 7
		elif GameState.boss_health> 40:
			boss.frame = 8
		elif GameState.boss_health==0:
			boss.frame = 9
			
func show_boss_health():
	$BossHealth.visible = true
	$Boss.visible = true
