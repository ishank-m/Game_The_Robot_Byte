extends CanvasLayer
@onready var shop_interface = $shop_interface
@onready var confirm_action = $CanvasLayer/confirm_action
var health_count = 0
var invin_count = 0
var frame = 0
var reset = false
 
func _ready():
	shop_interface.frame = 0


func _process(_delta):
	$shop_interface/health_potion_quantity.text = str(health_count)
	$shop_interface/invin_potion_quantity.text = str(invin_count)
	update_interface()

func update_interface():
	if shop_interface.frame == 0:
		$shop_interface/next_button.visible = true
		$shop_interface/back_button.visible = false
		frame = 0
		hide_buttons()
	if shop_interface.frame == 4:
		$shop_interface/next_button.visible = false
		$shop_interface/back_button.visible = true
		frame = 1
		show_buttons()

func hide_buttons():
	$shop_interface/minus.visible = false
	$shop_interface/minus2.visible = false
	$shop_interface/plus.visible = false
	$shop_interface/plus2.visible = false
	$shop_interface/health_potion_quantity.visible = false
	$shop_interface/invin_potion_quantity.visible = false
func show_buttons():
	$shop_interface/minus.visible = true
	$shop_interface/minus2.visible = true
	$shop_interface/plus.visible = true
	$shop_interface/plus2.visible = true
	$shop_interface/health_potion_quantity.visible = true
	$shop_interface/invin_potion_quantity.visible = true
func _on_next_button_pressed():
	$shop_interface/next_button.frame = 1
	$Timer.start()
	


func _on_back_button_pressed():
	$shop_interface/back_button.frame = 1
	$Timer.start()
	


func _on_minus_pressed():
	$shop_interface/minus.frame = 1
	$Timer.start()
	reset = true
	if health_count>0:
		health_count -= 1


func _on_plus_pressed():
	$shop_interface/plus.frame = 1
	$Timer.start()
	reset = true
	if health_count>= 0:
		health_count += 1


func _on_minus_2_pressed():
	$shop_interface/minus2.frame = 1
	$Timer.start()
	reset = true
	if invin_count>0:
		invin_count -= 1


func _on_plus_2_pressed():
	$shop_interface/plus2.frame = 1
	$Timer.start()
	reset = true
	if health_count>= 0:
		invin_count += 1

func reset_buttons():
	$shop_interface/minus.frame = 0
	$shop_interface/plus.frame = 0
	$shop_interface/minus2.frame = 0
	$shop_interface/plus2.frame = 0
	$shop_interface/next_button.frame = 0
	$shop_interface/back_button.frame = 0


func _on_timer_timeout():
	
	if frame == 1 and not reset:
		shop_interface.frame = 0
	elif frame == 0 and not reset:
		shop_interface.frame = 4
	elif reset:
		reset_buttons()
