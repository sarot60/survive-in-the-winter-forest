extends Panel

var food_processing_table = {
	"0": {
		"item_require": {
			"0": "105",
			"1": "104"
		},
		"item_reward": {
			"0": "501"
		}
	},
	"1": {
		"item_require": {
			"0": "201",
		},
		"item_reward": {
			"0": "504"
		}
	},
	"2": {
		"item_require": {
			"0": "203",
		},
		"item_reward": {
			"0": "506"
		}
	},
	"3": {
		"item_require": {
			"0": "202",
		},
		"item_reward": {
			"0": "505"
		}
	}
}

func _ready():
	pre_processing_food()

func pre_processing_food() -> void:
#	get_node("ScrollContainer/GridContainer/processing_0").modulate = Color(0.5,0.5,0.5,1)
#	get_node("ScrollContainer/GridContainer/processing_1").modulate = Color(0.5,0.5,0.5,1)
#	get_node("ScrollContainer/GridContainer/processing_2").modulate = Color(0.5,0.5,0.5,1)
#	get_node("ScrollContainer/GridContainer/processing_3").modulate = Color(0.5,0.5,0.5,1)

	for pr_no in range(0,4):
		# ของที่ต้องการ
		var item_require = food_processing_table[String(pr_no)]["item_require"]
		
		var _tmp_array = []
		
		# สร้าง arry สำหรับเก็บข้อมูลชั่วคราว
		for i in item_require:
			_tmp_array.append({
				str(i):{
					"id": "",
					"slot": -1,
					"have": false,
					"amount": 0,
				}
			})

		# หาไอเทมในกระเป่า
		for slot in range(0,40):
			var inventoryItem:Dictionary = gamestate.state.inventory[str(slot)]
			#print(gamestate.state.inventory[str(slot)])
			
			# เอาไอเทมที่ต้องการใส่ใน array
			for i in item_require:
				# ถ้าไอเทมที่ต้องการ เท่ากับ ไอเทมในกระเป๋า
				if item_require[i] == inventoryItem["id"]:
					_tmp_array[int(i)][str(i)]["have"] = true
					_tmp_array[int(i)][str(i)]["id"] = item_require[i]
					_tmp_array[int(i)][str(i)]["slot"] = slot
					_tmp_array[int(i)][str(i)]["amount"] += inventoryItem["amount"]
		
		# เช็คว่ามีครบไหม
		var false_stack:int = 0
		for i in _tmp_array.size():
			if _tmp_array[i][str(i)]["have"] == false:
				false_stack += 1
		
		if false_stack > 0:
			get_node("ScrollContainer/GridContainer/processing_"+str(pr_no)).modulate = Color(0.5, 0.5 ,0.5 ,1)
		else:
			get_node("ScrollContainer/GridContainer/processing_"+str(pr_no)).modulate = Color(1, 1, 1, 1)
			
func processing_food(pr_no:String) -> void:

	# ของที่ต้องการ
	var item_require = food_processing_table[pr_no]["item_require"]
	# ของรางวัล
	var item_reward = food_processing_table[pr_no]["item_reward"]
	
	var _tmp_array = []
	
	# สร้าง arry สำหรับเก็บข้อมูลชั่วคราว
	for i in item_require:
		_tmp_array.append({
			str(i):{
				"id": "",
				"slot": -1,
				"have": false,
				"amount": 0,
			}
		})

	# หาไอเทมในกระเป่า
	for slot in range(0,40):
		var inventoryItem:Dictionary = gamestate.state.inventory[str(slot)]
		#print(gamestate.state.inventory[str(slot)])
		
		# เอาไอเทมที่ต้องการใส่ใน array
		for i in item_require:
			# ถ้าไอเทมที่ต้องการ เท่ากับ ไอเทมในกระเป๋า
			if item_require[i] == inventoryItem["id"]:
				_tmp_array[int(i)][str(i)]["have"] = true
				_tmp_array[int(i)][str(i)]["id"] = item_require[i]
				_tmp_array[int(i)][str(i)]["slot"] = slot
				_tmp_array[int(i)][str(i)]["amount"] += inventoryItem["amount"]
	
	# เช็คว่ามีครบไหม
	var false_stack:int = 0
	for i in _tmp_array.size():
		if _tmp_array[i][str(i)]["have"] == false:
			false_stack += 1
	
	# ทำการแลกไอเทม ถ้ามีครบคือ 0
	if false_stack == 0:
		
		# ลบไอเทมที่ใช้คราฟ
		for i in _tmp_array.size():
			
			var item_slot:int = _tmp_array[i][str(i)]["slot"]
			var newAmount:int = gamestate.state.inventory[str(item_slot)]["amount"] - 1
		
			if newAmount < 1:
				DataParser.inventory_updateItem(item_slot, 0, 0)
			else:
				gamestate.state.inventory[str(item_slot)]["amount"] = newAmount
				
			game.inventory.update_slot(item_slot)
			
		# เพิ่มไอเทมที่ได้
		for i in item_reward:
			#print(item_reward[i])
			var affectedSlot = DataParser.inventory_addItem(int(item_reward[i]))
			if (affectedSlot >= 0):
				game.inventory.update_slot(affectedSlot)
				
		game.text_alert.add_data_to_play("แปรรูปสำเร็จ")
		pre_processing_food()
	else:
		game.text_alert.add_data_to_play("ไม่สามารถแปรรูปได้ ! ! !")
	
func _on_processing_0_button_pressed():
	processing_food("0")


func _on_processing_1_button_pressed():
	processing_food("1")


func _on_processing_2_button_pressed():
	processing_food("2")


func _on_processing_3_button_pressed():
	processing_food("3")
