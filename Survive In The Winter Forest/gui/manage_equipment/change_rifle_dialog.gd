extends WindowDialog

var cur_change_style_box = StyleBoxFlat.new()
#var can_change_style_box = StyleBoxFlat.new()
#var lock_change_style_box = StyleBoxFlat.new()
var unselect_style_box = StyleBoxFlat.new()

func _ready():
	# set current change 
	cur_change_style_box.set_bg_color(Color("#505050"))
	cur_change_style_box.set_border_width_all(16)
	cur_change_style_box.set_border_blend(true)
	
	# set unselect
	unselect_style_box.set_bg_color(Color("#505050"))
	
	$ScrollContainer/VBoxContainer/rifle_1/rifle_1_change.connect("pressed",self,"_on_rifle_1_change_pressed")
	$ScrollContainer/VBoxContainer/rifle_2/rifle_2_change.connect("pressed",self,"_on_rifle_2_change_pressed")
	$ScrollContainer/VBoxContainer/rifle_3/rifle_3_change.connect("pressed",self,"_on_rifle_3_change_pressed")
	
	#initiate()
	#pass

func initiate():
	$ScrollContainer/VBoxContainer/rifle_1.set('custom_styles/panel', unselect_style_box)
	$ScrollContainer/VBoxContainer/rifle_2.set('custom_styles/panel', unselect_style_box)
	$ScrollContainer/VBoxContainer/rifle_3.set('custom_styles/panel', unselect_style_box)
	
	var cur_rifle = str(gamestate.state.current_equipment.rifle)
	
	match cur_rifle:
		"1":
			$ScrollContainer/VBoxContainer/rifle_1.set('custom_styles/panel', cur_change_style_box)
		"2":
			$ScrollContainer/VBoxContainer/rifle_2.set('custom_styles/panel', cur_change_style_box)
		"3":
			$ScrollContainer/VBoxContainer/rifle_3.set('custom_styles/panel', cur_change_style_box)
			
	unlock_rifle()
	
func unlock_rifle():
	for i in range(2,4):
		if i == 2:
			if gamestate.state.level >= 10:
				get_node("ScrollContainer/VBoxContainer/rifle_2/Panel2").hide()
		elif i == 3:
			if gamestate.state.level >= 20:
				get_node("ScrollContainer/VBoxContainer/rifle_3/Panel2").hide()

func set_rifle(n):
	$ScrollContainer/VBoxContainer/rifle_1.set('custom_styles/panel', unselect_style_box)
	$ScrollContainer/VBoxContainer/rifle_2.set('custom_styles/panel', unselect_style_box)
	$ScrollContainer/VBoxContainer/rifle_3.set('custom_styles/panel', unselect_style_box)
	match n:
		1:
			$ScrollContainer/VBoxContainer/rifle_1.set('custom_styles/panel', cur_change_style_box)
			if game.main == null: return
			gamestate.state.current_equipment.rifle = "1"
			game.equ_gui.update_rifle()
			game.equ_hud.update_rifle_hud()
		2:
			$ScrollContainer/VBoxContainer/rifle_2.set('custom_styles/panel', cur_change_style_box)
			if game.main == null: return
			gamestate.state.current_equipment.rifle = "2"
			game.equ_gui.update_rifle()
			game.equ_hud.update_rifle_hud()
		3:
			$ScrollContainer/VBoxContainer/rifle_3.set('custom_styles/panel', cur_change_style_box)
			if game.main == null: return
			gamestate.state.current_equipment.rifle = "3"
			game.equ_gui.update_rifle()
			game.equ_hud.update_rifle_hud()
			
func _on_rifle_1_change_pressed():
	set_rifle(1)
	
func _on_rifle_2_change_pressed():
	set_rifle(2)
	
func _on_rifle_3_change_pressed():
	set_rifle(3)
	
