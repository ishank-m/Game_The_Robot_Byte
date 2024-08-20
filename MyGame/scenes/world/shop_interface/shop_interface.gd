extends CanvasLayer
#@onready var confirm_action = $CanvasLayer/confirm_action
var health_count = 0
var invin_count = 0
var sword
func hide_shop():
	$ShopInterfaceBg.visible = false

func shop():
	GameState.game_state = "pause"
	set_process_input(true)
	if not GameState.dialogues_count['shop']:
		GameState.dialogues_count['shop'] = 1
		Dialogic.start("shop1")
		Dialogic.VAR.points = GameState.points
		Dialogic.signal_event.connect(_on_dialogic_signal)
	show_swords()
func _on_close_pressed():
	$ShopInterfaceBg.visible = false
	GameState.game_state = "play"
func _process(_delta):
	$ShopInterfaceBg/potionSection/invin_pot_count.text = str(invin_count)
	$ShopInterfaceBg/potionSection/health_pot_count.text = str(health_count)

func _on_next_pressed():
	show_potions()

func _on_dialogic_signal(argument):
	if argument == "done1":
		set_process_input(true)
		$ShopInterfaceBg.visible = true

func _on_iron_button_down():
	sword = "iron"

func show_swords():
	$ShopInterfaceBg.frame = 0
	$ShopInterfaceBg/potionSection.visible = false
	$ShopInterfaceBg/swordSection.visible = true
func show_potions():
	$ShopInterfaceBg.frame = 1
	$ShopInterfaceBg/swordSection.visible = false
	$ShopInterfaceBg/potionSection.visible = true

func _on_gold_button_down():
	sword = "gold"


func _on_diamond_button_down():
	sword = "diamond"


func _on_buy_pressed():
	print(sword)


func _on_back_pressed():
	show_swords()


func _on_plus_1_pressed():
	if health_count>-1 and health_count<6:
		health_count += 1
	if health_count>5:
		health_count = 5


func _on_plus_2_pressed():
	if invin_count>-1 and invin_count<6:
		invin_count += 1
	if invin_count>5:
		invin_count = 5

func _on_minus_1_pressed():
	if health_count>-1 and health_count<6:
		health_count -= 1
	if health_count<0:
		health_count = 0

func _on_minus_2_pressed():
	if invin_count>-1 and invin_count<6:
		invin_count -= 1
	if invin_count<0:
		invin_count = 0


func _on_buy_pot_pressed():
	print(invin_count, health_count)
	
