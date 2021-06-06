extends Control

var current_quest_style = StyleBoxFlat.new()
var cannot_accepted_quest_style = StyleBoxFlat.new()
var success_quest_style = StyleBoxFlat.new()


func _ready():
	
	# ปิดไอเทมที่ต้องการของเควส
	$Panel/quest_detail/item_require/item_list_for_quest.hide()
	
	# เควสปัจจุบัน
	current_quest_style.set_bg_color(Color("#565a2d"))
	current_quest_style.set_corner_radius_all(16)
	
	# เควสที่ทำเสร็จแล้ว
	success_quest_style.set_bg_color(Color("#2c5931"))
	success_quest_style.set_corner_radius_all(16)
	
	# เควสที่ยังรับไม่ได้
	cannot_accepted_quest_style.set_bg_color(Color("#464646"))
	cannot_accepted_quest_style.set_corner_radius_all(16)
	
	game.quest = self
	initiate()
	
func initiate():
	# ลูปเควสทั้ง 9 เควส เพื่อ update ui
	for i in JsonGameMetaData.quest:
		$Panel/quest_list/ScrollContainer/GridContainer.get_node("quest_"+str(i)).get_node("Label").text = \
		str(i) + ". " + JsonGameMetaData.quest[str(i)]["quest_name"]
		
		# ถ้าเป็นเควสปัจจุบัน
		if str(i) == gamestate.state.quest.current_quest:
			# ถ้ารับเควสปัจจุบันแล้ว
			#if gamestate.state.quest.accepted_quest == 1:
				#print("รับแล้ว")
				#pass
			# มีเควสแต่ยังไม่ได้รับ
			#else:
				#print("ยังไม่รับเควส")
				#pass
			get_node("Panel/quest_list/ScrollContainer/GridContainer").get_node("quest_"+str(i)).\
			set('custom_styles/panel', current_quest_style)
		else:
			# เควสที่ผ่านมาแล้ว
			if int(gamestate.state.quest.current_quest) > int(i):
				get_node("Panel/quest_list/ScrollContainer/GridContainer").get_node("quest_"+str(i)).\
				set('custom_styles/panel', success_quest_style)
			# เควสที่ยังรับไม่ได้
			elif int(gamestate.state.quest.current_quest) < int(i):
				get_node("Panel/quest_list/ScrollContainer/GridContainer").get_node("quest_"+str(i)).\
				set('custom_styles/panel', cannot_accepted_quest_style)
		
	
	if gamestate.state.quest.current_quest == "0010":
		show_quest_detail("009")
	else:
		show_quest_detail(gamestate.state.quest.current_quest)
	
	
func update_gui():
	initiate()

# แสดงรายละเอียดเควส
func show_quest_detail(quest_number):
	
	# ราบละเอียดของเควสนั้นๆ
	$Panel/quest_detail/RichTextLabel.text = "เควส "+quest_number+ "\n" \
	+ "ชื่อเควส : " + JsonGameMetaData.quest[str(quest_number)]["quest_name"] + "\n" \
	+ "รับเควสจาก npc " + JsonGameMetaData.quest[str(quest_number)]["npc_name"] + "\n" 

				
				
	# ถ้าเป็นเควสปัจจุบัน
	if str(quest_number) == gamestate.state.quest.current_quest:
		
		
		# ถ้ารับเควสปัจจุบันแล้ว
		if gamestate.state.quest.accepted_quest == 1:
			$Panel/quest_detail/item_require/item_list_for_quest.show()
			
			$Panel/quest_detail/item_require/quest_status.hide()

			# ทำให้ sprite ว่าง
			for i in range(0,4):
				get_node("Panel/quest_detail/item_require/item_list_for_quest/GridContainer"). \
				get_node("item_"+str(i)).get_node("Sprite").texture = null
				
				get_node("Panel/quest_detail/item_require/item_list_for_quest/GridContainer"). \
				get_node("item_"+str(i)).get_node("item_count").text = " "
			
			# ไอเทมที่ต้องการในเควส
			for i in JsonGameMetaData.quest[gamestate.state.quest.current_quest]["item_quest_require"]:
				get_node("Panel/quest_detail/item_require/item_list_for_quest/GridContainer"). \
				get_node("item_"+i).get_node("Sprite").texture = load(\
					JsonGameMetaData.item_meta_data[JsonGameMetaData.quest[gamestate.state.quest.current_quest]["item_quest_require"][i]].icon
				)
				
				get_node("Panel/quest_detail/item_require/item_list_for_quest/GridContainer"). \
				get_node("item_"+i).get_node("item_count").text = \
				str(gamestate.state.quest["tmp_item_quest"][JsonGameMetaData.quest[gamestate.state.quest.current_quest]["item_quest_require"][i]])+"/1"

			#$Panel/quest_detail/item_require/quest_status.text = "รับแล้ว"
		
		# ถ้ายังไม่รับเควสปัจจุบัน 
		else:
			$Panel/quest_detail/item_require/item_list_for_quest.hide()
			
			$Panel/quest_detail/item_require/quest_status.show()
			$Panel/quest_detail/item_require/quest_status.text = "ยังไม่รับเควส"
	# ถ้าไม่ใช่เควสปัจจุบีน
	else:
		# เควสที่ผ่านมาแล้ว
		if int(gamestate.state.quest.current_quest) > int(quest_number):
			$Panel/quest_detail/item_require/item_list_for_quest.hide()
			
			$Panel/quest_detail/item_require/quest_status.show()
			$Panel/quest_detail/item_require/quest_status.text = "ทำเควสสำเร็จแล้ว"
			
		# เควสที่ยังไม่รับ
		elif int(gamestate.state.quest.current_quest) < int(quest_number):
			$Panel/quest_detail/item_require/item_list_for_quest.hide()
			
			$Panel/quest_detail/item_require/quest_status.show()
			$Panel/quest_detail/item_require/quest_status.text = "ยังรับเควสไม่ได้"
			
	# ของรางวัล เช่น exp money
	var exp_reward:String = str(JsonGameMetaData.quest[str(quest_number)]["rewards"]["exp"])
	var money_reward:String = str(JsonGameMetaData.quest[str(quest_number)]["rewards"]["money"])
	var perk_point_reward:String = str(JsonGameMetaData.quest[str(quest_number)]["rewards"]["perk_point"])
	
	var _tmpStr:String = ""
	_tmpStr = _tmpStr + "ของรางวัล \n"
	_tmpStr = _tmpStr + "\t\tค่าประสบการณ์ Exp :" + exp_reward +  "\n"
	_tmpStr = _tmpStr + "\t\tเงิน : " + money_reward + "\n"
	_tmpStr = _tmpStr + "\t\tแต้มอัพทักษะ : " + perk_point_reward
	$Panel/quest_detail/quest_rewards/RichTextLabel.text = _tmpStr
	

# --------------------------------- Signals ------------------------------------

func _on_close_button_pressed():
	if game.main == null: return
	game.gui.set_gui(1)

#333333333333333333333333333333333333333333333333333333333333333
func _on_quest_001_button_pressed():
	show_quest_detail("001")


func _on_quest_002_button_pressed():
	show_quest_detail("002")


func _on_quest_003_button_pressed():
	show_quest_detail("003")


func _on_quest_004_button_pressed():
	show_quest_detail("004")


func _on_quest_005_button_pressed():
	show_quest_detail("005")


func _on_quest_006_button_pressed():
	show_quest_detail("006")


func _on_quest_007_button_pressed():
	show_quest_detail("007")


func _on_quest_008_button_pressed():
	show_quest_detail("008")


func _on_quest_009_button_pressed():
	show_quest_detail("009")


func _on_quest_010_button_pressed():
	show_quest_detail("010")
