extends Control

var str_player_status = null

func _ready():
	game.player_detail = self
	

func initiate():
	if game.main == null: return
	
#	var level = str(gamestate.state.level)
#	var money = str(gamestate.state.money)
#	#var move_speed = str(gamestate.state.move_speed)
#	var health = str(gamestate.state.health)
#	var food = str(gamestate.state.food)
#	var water = str(gamestate.state.water)
#	var sniper_damage = str(gamestate.state.sniper_damage)
#	var pistol_damage = str(gamestate.state.pistol_damage)
#	var knife_damage = str(gamestate.state.knife_damage)
#	#var reducation_food_rate = str(gamestate.state.reducation_food_rate)
#	#var reducation_water_rate = str(gamestate.state.reducation_water_rate)
#	var day = str(gamestate.state.day)
#	var perk_point = str(gamestate.state.perk_point)
#	var max_survival_day = str(gamestate.state.max_survival_day)
#
#	str_player_status = null
#
#	str_player_status = "Level = " + level + "\n"
#	str_player_status = str_player_status + "Survival Day = " + day + "\n"
#	str_player_status = str_player_status + "เงิน = " + money + "\n"
#	str_player_status = str_player_status + "เลือด = " + health + "\n"
#	str_player_status = str_player_status + "อาหาร = " + food + "\n"
#	str_player_status = str_player_status + "น้ำ = " + water + "\n"
#	str_player_status = str_player_status + "ความแรงสไนเปอร์ = " + sniper_damage + "\n"
#	str_player_status = str_player_status + "ความแรงของปืนพก = " + pistol_damage + "\n"
#	str_player_status = str_player_status + "ความแรงของมีด = " + knife_damage + "\n"
#	str_player_status = str_player_status + "แต้มอัพสกิล = " + perk_point + "\n"
#
#	$Panel/detail/RichTextLabel.text = str_player_status
	$Panel/exp_progress.value = gamestate.state.exp
	
	set_data_to_table()

var player_status_dict = [
	{ 
		"key": "level",
		"text": "เลเวล"
	},
	{
		"key": "money",
		"text": "เงิน"
	},
	{
		"key": "day",
		"text": "วันที่เอาชีวิตรอดล่าสุด"
	},
	{
		"key": "max_survival_day",
		"text": "จำนวนวันที่เอาชีวิตรอดสูงสุด"
	},
	{
		"key": "health",
		"text": "เลือด"
	},
	{
		"key": "food",
		"text": "อาหาร"
	},
	{
		"key": "water",
		"text": "น้ำ"
	},
	{
		"key": "sniper_damage",
		"text": "ความแรงปืนสไนเปอร์"
	},
	{
		"key": "pistol_damage",
		"text": "ความแรงของปืนพก"
	},
	{
		"key": "knife_damage",
		"text": "ความแรงของมีด"
	},
	{
		"key": "perk_point",
		"text": "แต้มอัพสกิล"
	},
	{
		"key": "deer_kill",
		"text": "จำนวนกวางที่ล่าทั้งหมด"
	},
	{
		"key": "rabbit_kill",
		"text": "จำนวนกระต่ายที่ล่าทั้งหมด"
	},
	{
		"key": "wolf_kill",
		"text": "จำนวนหมาป่าที่ล่าทั้งหมด"
	},
]

func set_data_to_table():
	if get_node("Panel/detail/ScrollContainer/GridContainer").get_child_count() > 0:
		for i in get_node("Panel/detail/ScrollContainer/GridContainer").get_children():
			i.queue_free()
			
	var detail_table = get_node("Table_Ins")
	for i in player_status_dict:
		var dt = detail_table.duplicate()
		dt.get_node("Panel/Label").text = i["text"]
		dt.get_node("Panel2/Label").text = str(gamestate.state[i["key"]])
		dt.show()
		$Panel/detail/ScrollContainer/GridContainer.add_child(dt)
		
	pass

func update_gui():
	initiate()
	pass

func increase_exp(up_ex:int):
	#if game.main == null: return
	
	var available_exp = gamestate.state.exp
	
	var total_exp = available_exp + up_ex
	
	var total_up_lv = total_exp / 100
	var remaining_exp = total_exp % 100
	
	gamestate.state.perk_point += total_up_lv
	gamestate.state.level += total_up_lv
	gamestate.state.exp = remaining_exp
	
	update_gui()
	
	if game.main != null:
		game.hp_food_water_bar.initiate()
	
	
# ------------------------- Signal ---------------------------------
	
func _on_close_button_pressed():
	if game.main == null: return
	game.gui.set_gui(1)
