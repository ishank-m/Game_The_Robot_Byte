extends CanvasLayer
var health_count = 0
var invin_count = 0
var sword

func shop():
	GameState.game_state = "pause"
	set_process_input(true)
	if GameState.dialogues_count['shop'] == 0:
		GameState.dialogues_count['shop'] = 1
		Dialogic.start("shop1")
		Dialogic.VAR.points = GameState.points
		Dialogic.signal_event.connect(_on_dialogic_signal)
	else:
		$ShopInterfaceBg.visible = true
		$Panel.visible = true
	show_swords()
func _on_close_pressed():
	$click_sound.play()
	$ShopInterfaceBg.visible = false
	GameState.game_state = "play"
	GameState.pausable = true
	$Panel.visible = false
func _process(_delta):
	$Panel/points_counter.text = "Points: "+str(GameState.points)
	$ShopInterfaceBg/potionSection/invin_pot_count.text = str(invin_count)
	$ShopInterfaceBg/potionSection/health_pot_count.text = str(health_count)

func _on_next_pressed():
	$click_sound.play()
	show_potions()

func _on_dialogic_signal(argument):
	if argument == "done_shop1":
		$ShopInterfaceBg.visible = true
		$Panel.visible = true
	if argument == "done_shop2" or argument == "done3":
		show_shop()
	set_process_input(true)

func show_swords():
	$ShopInterfaceBg.frame = 0
	$ShopInterfaceBg/potionSection.visible = false
	$ShopInterfaceBg/swordSection.visible = true
func show_potions():
	$ShopInterfaceBg.frame = 1
	$ShopInterfaceBg/swordSection.visible = false
	$ShopInterfaceBg/potionSection.visible = true
func _on_iron_button_down():
		sword = "iron"
func _on_gold_button_down():
	sword = "gold"
func _on_diamond_button_down():
	sword = "diamond"


func _on_buy_pressed():
	$click_sound.play()
	set_process_input(false)
	if sword == "iron":
		if GameState.points >= 180:
			GameState.items["sword"] = sword
			GameState.sword_damage = 12
			GameState.points -= 180
			$Label.text = "+1 Iron Sword"
			$ShopInterfaceBg/swordSection/Buy.disabled = true
			Dialogic.VAR.sword = sword
			hide_shop()
			Dialogic.start("shop3")
			$Timer.start()
		else:
			hide_shop()
			Dialogic.start("shop2")
	elif sword == "gold":
		if GameState.points >= 260:
			$Label.text = "+1 Gold Sword"
			GameState.items["sword"] = sword
			GameState.sword_damage = 18
			GameState.points -= 260
			$ShopInterfaceBg/swordSection/Buy.disabled = true
			Dialogic.VAR.sword = sword
			hide_shop()
			Dialogic.start("shop3")
			$Timer.start()
		else:
			hide_shop()
			Dialogic.start("shop2")
	elif sword == "diamond":
		if GameState.points >= 300:
			$Label.text = "+1 Diamond Sword"
			GameState.items["sword"] = sword
			GameState.sword_damage = 36
			GameState.points -= 300
			$ShopInterfaceBg/swordSection/Buy.disabled = true
			Dialogic.VAR.sword = sword
			hide_shop()
			Dialogic.start("shop3")
			$Timer.start()
		else:
			hide_shop()
			Dialogic.start("shop2")
func _on_back_pressed():
	$click_sound.play()
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
	$click_sound.play()
	var amount = health_count*50 + invin_count*50
	if amount<GameState.points and amount != 0:
		GameState.points -= amount
		$Timer.start()
		GameState.items["health_potion"] += health_count
		GameState.items["invin_potion"] += invin_count
		if invin_count == 1 and health_count == 1:
			$Label.text = "+"+str(health_count)+" Health Potion\n+"+str(invin_count)+" Invincibility Potion"
		elif invin_count == 1 and health_count !=1:
			$Label.text = "+"+str(health_count)+" Health Potions\n+"+str(invin_count)+" Invincibility Potion"
		elif invin_count != 1 and health_count == 1:
			$Label.text = "+"+str(health_count)+" Health Potion\n+"+str(invin_count)+" Invincibility Potions"
		else:
			$Label.text = "+"+str(health_count)+" Health Potions\n+"+str(invin_count)+" Invincibility Potions"
	else:
		set_process_input(false)
		hide_shop()
		Dialogic.start("shop2")
	health_count = 0
	invin_count = 0
func _on_timer_timeout():
	$Label.text = ""
func show_shop():
	$ShopInterfaceBg.visible = true
	$Panel.visible = true
func hide_shop():
	$ShopInterfaceBg.visible = false
	$Panel.visible = false
