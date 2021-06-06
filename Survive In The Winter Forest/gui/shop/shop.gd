extends Control


func _ready():
	game.shop = self
	

func initiate():
	show()
	$player_money/money.text = str(gamestate.state.money)

func update_current():
	$player_money/money.text = str(gamestate.state.money)

func close_shop():
	hide()


func _on_itm_0_button_pressed():
	if gamestate.state.money < 500: return
	
	gamestate.state.money -= 500
	update_current()
	gamestate.state.sniper_mag += 5
	game.equ_hud.update_hud()


func _on_itm_1_button_pressed():
	if gamestate.state.money < 250: return
	
	gamestate.state.money -= 250
	update_current()
	gamestate.state.pistol_mag += 12
	game.equ_hud.update_hud()


func _on_itm_2_button_pressed():
	if gamestate.state.money < 100: return
	
	gamestate.state.money -= 100
	update_current()
	
	var affectedSlot = DataParser.inventory_addItem(104)
	if (affectedSlot >= 0):
		game.inventory.update_slot(affectedSlot)
	

func _on_itm_3_button_pressed():
	if gamestate.state.money < 100: return
	
	gamestate.state.money -= 100
	update_current()
	
	var affectedSlot = DataParser.inventory_addItem(102)
	if (affectedSlot >= 0):
		game.inventory.update_slot(affectedSlot)
