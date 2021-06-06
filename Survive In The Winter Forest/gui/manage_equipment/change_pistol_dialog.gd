extends WindowDialog

var cur_change_style_box = StyleBoxFlat.new()
var unselect_style_box = StyleBoxFlat.new()

func _ready():
	# set current change 
	cur_change_style_box.set_bg_color(Color("#505050"))
	cur_change_style_box.set_border_width_all(16)
	cur_change_style_box.set_border_blend(true)
	
	# set unselect
	unselect_style_box.set_bg_color(Color("#505050"))
	
	$ScrollContainer/VBoxContainer/pistol_1/pistol_1_change.connect("pressed",self,"_on_pistol_1_change_pressed")
	$ScrollContainer/VBoxContainer/pistol_2/pistol_2_change.connect("pressed",self,"_on_pistol_2_change_pressed")
	$ScrollContainer/VBoxContainer/pistol_3/pistol_3_change.connect("pressed",self,"_on_pistol_3_change_pressed")

func initiate():
	$ScrollContainer/VBoxContainer/pistol_1.set('custom_styles/panel', unselect_style_box)
	$ScrollContainer/VBoxContainer/pistol_2.set('custom_styles/panel', unselect_style_box)
	$ScrollContainer/VBoxContainer/pistol_3.set('custom_styles/panel', unselect_style_box)
	
	var cur_pistol = str(gamestate.state.current_equipment.pistol)
	
	match cur_pistol:
		"1":
			$ScrollContainer/VBoxContainer/pistol_1.set('custom_styles/panel', cur_change_style_box)
		"2":
			$ScrollContainer/VBoxContainer/pistol_2.set('custom_styles/panel', cur_change_style_box)
		"3":
			$ScrollContainer/VBoxContainer/pistol_3.set('custom_styles/panel', cur_change_style_box)
			
	unlock_pistol()
	
func unlock_pistol():
	for i in range(2,4):
		if i == 2:
			if gamestate.state.level >= 5:
				get_node("ScrollContainer/VBoxContainer/pistol_2/Panel2").hide()
		elif i == 3:
			if gamestate.state.level >= 10:
				get_node("ScrollContainer/VBoxContainer/pistol_3/Panel2").hide()
				
func set_pistol(n):
	$ScrollContainer/VBoxContainer/pistol_1.set('custom_styles/panel', unselect_style_box)
	$ScrollContainer/VBoxContainer/pistol_2.set('custom_styles/panel', unselect_style_box)
	$ScrollContainer/VBoxContainer/pistol_3.set('custom_styles/panel', unselect_style_box)
	match n:
		1:
			$ScrollContainer/VBoxContainer/pistol_1.set('custom_styles/panel', cur_change_style_box)
			if game.main == null: return
			gamestate.state.current_equipment.pistol = "1"
			game.equ_gui.update_pistol()
			game.equ_hud.update_pistol_hud()
		2:
			$ScrollContainer/VBoxContainer/pistol_2.set('custom_styles/panel', cur_change_style_box)
			if game.main == null: return
			gamestate.state.current_equipment.pistol = "2"
			game.equ_gui.update_pistol()
			game.equ_hud.update_pistol_hud()
		3:
			$ScrollContainer/VBoxContainer/pistol_3.set('custom_styles/panel', cur_change_style_box)
			if game.main == null: return
			gamestate.state.current_equipment.pistol = "3"
			game.equ_gui.update_pistol()
			game.equ_hud.update_pistol_hud()
			
func _on_pistol_1_change_pressed():
	set_pistol(1)
	
func _on_pistol_2_change_pressed():
	set_pistol(2)
	
func _on_pistol_3_change_pressed():
	set_pistol(3)
