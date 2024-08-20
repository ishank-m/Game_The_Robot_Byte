extends CanvasLayer
#need to addd king's health var from global script
@onready var bar = $bar
@onready var critical_health = $critical_health
@onready var kbar = $bar_king
@onready var kcritical_health = $critical_health_king
var khealth = 120
func _ready():
	$BossHealth.visible = false
	critical_health.visible = false
	bar.visible = true
	kcritical_health.visible = false
	kbar.visible = true

func _process(_delta):
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
		if not critical_health.visible:
			bar.visible = false
			critical_health.visible = true
			critical_health.play("default")
	if khealth > 110:
		kbar.frame = 0
	elif khealth > 100:
		kbar.frame = 1
	elif khealth > 90:
		kbar.frame = 2
	elif khealth > 80:
		kbar.frame = 3
	elif khealth > 70:
		kbar.frame = 4
	elif khealth > 60:
		kbar.frame = 5
	elif khealth > 50:
		kbar.frame = 6
	elif khealth > 40:
		kbar.frame = 7
	elif khealth > 30:
		kbar.frame = 8
	elif khealth > 20:
		kbar.frame = 9
	elif khealth > 10:
		kbar.frame = 10
		if not kcritical_health.visible:
			kbar.visible = false
			kcritical_health.visible = true
			kcritical_health.play("default")

func show_boss_health():
	$BossHealth.visible = true
