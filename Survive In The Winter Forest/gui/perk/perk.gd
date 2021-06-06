extends Control

var cur_perk_index:String = ""

func _ready():
	game.perk = self
	
	var _tmpConnect = $Panel/details/upgrade_button.connect("pressed", self, "_on_upgrade_button_pressed")
	
	initiate()

func initiate():
	update_detail("0")
	
	if gamestate.state.perk["0"] == 1:
		gamestate.state.move_speed = 210
	elif gamestate.state.perk["0"] == 2:
		gamestate.state.move_speed = 220
	elif gamestate.state.perk["0"] == 3:
		gamestate.state.move_speed = 230
	elif gamestate.state.perk["0"] == 4:
		gamestate.state.move_speed = 240
	elif gamestate.state.perk["0"] == 5:
		gamestate.state.move_speed = 250
		
	if gamestate.state.perk["1"] == 1:
		gamestate.state.health = 110
	elif gamestate.state.perk["1"] == 2:
		gamestate.state.health = 120
	elif gamestate.state.perk["1"] == 3:
		gamestate.state.health = 130
	elif gamestate.state.perk["1"] == 4:
		gamestate.state.health = 140
	elif gamestate.state.perk["1"] == 5:
		gamestate.state.health = 150
		
	if gamestate.state.perk["2"] == 1:
		gamestate.state.reducation_water_rate = 0.9
	elif gamestate.state.perk["2"] == 2:
		gamestate.state.reducation_water_rate = 0.8
	elif gamestate.state.perk["2"] == 3:
		gamestate.state.reducation_water_rate = 0.7
	elif gamestate.state.perk["2"] == 4:
		gamestate.state.reducation_water_rate = 0.6
	elif gamestate.state.perk["2"] == 5:
		gamestate.state.reducation_water_rate = 0.5
		
	if gamestate.state.perk["3"] == 1:
		gamestate.state.reducation_food_rate = 0.9
	elif gamestate.state.perk["3"] == 2:
		gamestate.state.reducation_food_rate = 0.8
	elif gamestate.state.perk["3"] == 3:
		gamestate.state.reducation_food_rate = 0.7
	elif gamestate.state.perk["3"] == 4:
		gamestate.state.reducation_food_rate = 0.6
	elif gamestate.state.perk["3"] == 5:
		gamestate.state.reducation_food_rate = 0.5
		
	if gamestate.state.perk["4"] == 1:
		gamestate.state.sniper_damage = 110
	elif gamestate.state.perk["4"] == 2:
		gamestate.state.sniper_damage = 120
	elif gamestate.state.perk["4"] == 3:
		gamestate.state.sniper_damage = 130
	elif gamestate.state.perk["4"] == 4:
		gamestate.state.sniper_damage = 140
	elif gamestate.state.perk["4"] == 5:
		gamestate.state.sniper_damage = 150
		
	if gamestate.state.perk["5"] == 1:
		gamestate.state.pistol_damage = 55
	elif gamestate.state.perk["5"] == 2:
		gamestate.state.pistol_damage = 60
	elif gamestate.state.perk["5"] == 3:
		gamestate.state.pistol_damage = 65
	elif gamestate.state.perk["5"] == 4:
		gamestate.state.pistol_damage = 70
	elif gamestate.state.perk["5"] == 5:
		gamestate.state.pistol_damage = 75
		
	if gamestate.state.perk["6"] == 1:
		gamestate.state.knife_damage = 25
	elif gamestate.state.perk["6"] == 2:
		gamestate.state.knife_damage = 30
	elif gamestate.state.perk["6"] == 3:
		gamestate.state.knife_damage = 35
	elif gamestate.state.perk["6"] == 4:
		gamestate.state.knife_damage = 40
	elif gamestate.state.perk["6"] == 5:
		gamestate.state.knife_damage = 45
		
	if gamestate.state.perk["7"] == 1:
		gamestate.state.animal_visible_range = 1
	elif gamestate.state.perk["7"] == 2:
		gamestate.state.animal_visible_range = 2
	elif gamestate.state.perk["7"] == 3:
		gamestate.state.animal_visible_range = 3
	elif gamestate.state.perk["7"] == 4:
		gamestate.state.animal_visible_range = 4
	elif gamestate.state.perk["7"] == 5:
		gamestate.state.animal_visible_range = 5

func update_gui():
	initiate()

func update_detail(perk_no:String) -> void:
	
	#for i in gamestate.state.perk:
	#	print(JsonGameMetaData.perk[i])
	
	#for i in range(0,8):
	#	if gamestate.state.perk[str(i)] == 0:
	#		print('yes')

	if gamestate.state.perk["0"] == 1:
		gamestate.state.move_speed = 210
	elif gamestate.state.perk["0"] == 2:
		gamestate.state.move_speed = 220
	elif gamestate.state.perk["0"] == 3:
		gamestate.state.move_speed = 230
	elif gamestate.state.perk["0"] == 4:
		gamestate.state.move_speed = 240
	elif gamestate.state.perk["0"] == 5:
		gamestate.state.move_speed = 250
		
	if gamestate.state.perk["1"] == 1:
		gamestate.state.health = 110
	elif gamestate.state.perk["1"] == 2:
		gamestate.state.health = 120
	elif gamestate.state.perk["1"] == 3:
		gamestate.state.health = 130
	elif gamestate.state.perk["1"] == 4:
		gamestate.state.health = 140
	elif gamestate.state.perk["1"] == 5:
		gamestate.state.health = 150
		
	if gamestate.state.perk["2"] == 1:
		gamestate.state.reducation_water_rate = 0.9
	elif gamestate.state.perk["2"] == 2:
		gamestate.state.reducation_water_rate = 0.8
	elif gamestate.state.perk["2"] == 3:
		gamestate.state.reducation_water_rate = 0.7
	elif gamestate.state.perk["2"] == 4:
		gamestate.state.reducation_water_rate = 0.6
	elif gamestate.state.perk["2"] == 5:
		gamestate.state.reducation_water_rate = 0.5
		
	if gamestate.state.perk["3"] == 1:
		gamestate.state.reducation_food_rate = 0.9
	elif gamestate.state.perk["3"] == 2:
		gamestate.state.reducation_food_rate = 0.8
	elif gamestate.state.perk["3"] == 3:
		gamestate.state.reducation_food_rate = 0.7
	elif gamestate.state.perk["3"] == 4:
		gamestate.state.reducation_food_rate = 0.6
	elif gamestate.state.perk["3"] == 5:
		gamestate.state.reducation_food_rate = 0.5
		
	if gamestate.state.perk["4"] == 1:
		gamestate.state.sniper_damage = 110
	elif gamestate.state.perk["4"] == 2:
		gamestate.state.sniper_damage = 120
	elif gamestate.state.perk["4"] == 3:
		gamestate.state.sniper_damage = 130
	elif gamestate.state.perk["4"] == 4:
		gamestate.state.sniper_damage = 140
	elif gamestate.state.perk["4"] == 5:
		gamestate.state.sniper_damage = 150
		
	if gamestate.state.perk["5"] == 1:
		gamestate.state.pistol_damage = 55
	elif gamestate.state.perk["5"] == 2:
		gamestate.state.pistol_damage = 60
	elif gamestate.state.perk["5"] == 3:
		gamestate.state.pistol_damage = 65
	elif gamestate.state.perk["5"] == 4:
		gamestate.state.pistol_damage = 70
	elif gamestate.state.perk["5"] == 5:
		gamestate.state.pistol_damage = 75
		
	if gamestate.state.perk["6"] == 1:
		gamestate.state.knife_damage = 25
	elif gamestate.state.perk["6"] == 2:
		gamestate.state.knife_damage = 30
	elif gamestate.state.perk["6"] == 3:
		gamestate.state.knife_damage = 35
	elif gamestate.state.perk["6"] == 4:
		gamestate.state.knife_damage = 40
	elif gamestate.state.perk["6"] == 5:
		gamestate.state.knife_damage = 45
		
	if gamestate.state.perk["7"] == 1:
		gamestate.state.animal_visible_range = 1
	elif gamestate.state.perk["7"] == 2:
		gamestate.state.animal_visible_range = 2
	elif gamestate.state.perk["7"] == 3:
		gamestate.state.animal_visible_range = 3
	elif gamestate.state.perk["7"] == 4:
		gamestate.state.animal_visible_range = 4
	elif gamestate.state.perk["7"] == 5:
		gamestate.state.animal_visible_range = 5
		
		
	$Panel/details/TextureRect.texture = load(JsonGameMetaData.perk[perk_no]["icon"])
	
	$Panel/details/perk_description.text = JsonGameMetaData.perk[perk_no]["description"]
	
	var have_point:String = str(gamestate.state.perk_point)
	var point_req:String = str(JsonGameMetaData.perk[perk_no]["perk_point_req"])
	var cur_progress:String = str(gamestate.state.perk[perk_no])
	var max_progress:String = str(JsonGameMetaData.perk[perk_no]["max_progress"])
	
	$Panel/details/player_point.text = "แต้มที่มี " + have_point
	$Panel/details/point_req.text = "แต้มที่ต้องการ " + point_req
	
	$Panel/details/upgrade_progress.text = cur_progress + " / " + max_progress
	
	cur_perk_index = perk_no
	
# ------------------ Signals ------------------------

func _on_upgrade_button_pressed() -> void:
	if cur_perk_index == "":return
	
	var have_point:int = gamestate.state.perk_point
	#var point_req:int = JsonGameMetaData.perk[cur_perk_index]["perk_point_req"]
	var cur_progress:int = gamestate.state.perk[cur_perk_index]
	var max_progress:int = JsonGameMetaData.perk[cur_perk_index]["max_progress"]
	
	if have_point == 0: 
		game.text_alert.add_data_to_play("มีแต้มไม่เพียงพอต่อการอัพทักษะ")
		return
	if cur_progress == max_progress: 
		game.text_alert.add_data_to_play("ทักษะนี้ไม่สามารถอัพได้อีก")
		return
	
	gamestate.state.perk_point -= 1
	gamestate.state.perk[cur_perk_index] += 1
	
	update_detail(cur_perk_index)
	
	game.text_alert.add_data_to_play("อัพทักษะ " + str(JsonGameMetaData.perk[cur_perk_index]["name"]) + " สำเร็จแล้ว")
	

func _on_close_button_pressed():
	if game.main == null: return
	game.gui.set_gui(1)


func _on_skill_0_pressed():
	update_detail("0")


func _on_skill_1_pressed():
	update_detail("1")


func _on_skill_2_pressed():
	update_detail("2")


func _on_skill_3_pressed():
	update_detail("3")


func _on_skill_4_pressed():
	update_detail("4")


func _on_skill_5_pressed():
	update_detail("5")


func _on_skill_6_pressed():
	update_detail("6")


func _on_skill_7_pressed():
	update_detail("7")
