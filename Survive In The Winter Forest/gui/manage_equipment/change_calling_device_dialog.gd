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
	
	$ScrollContainer/VBoxContainer/calling_device_1/calling_device_1_change.connect("pressed",self,"_on_calling_device_1_change_pressed")
	$ScrollContainer/VBoxContainer/calling_device_2/calling_device_2_change.connect("pressed",self,"_on_calling_device_2_change_pressed")

func initiate():
	$ScrollContainer/VBoxContainer/calling_device_1.set('custom_styles/panel', unselect_style_box)
	$ScrollContainer/VBoxContainer/calling_device_2.set('custom_styles/panel', unselect_style_box)
	
	var cur_calling_device = str(gamestate.state.current_equipment.calling_device)
	
	match cur_calling_device:
		"1":
			$ScrollContainer/VBoxContainer/calling_device_1.set('custom_styles/panel', cur_change_style_box)
		"2":
			$ScrollContainer/VBoxContainer/calling_device_2.set('custom_styles/panel', cur_change_style_box)
			
func set_calling_device(n):
	$ScrollContainer/VBoxContainer/calling_device_1.set('custom_styles/panel', unselect_style_box)
	$ScrollContainer/VBoxContainer/calling_device_2.set('custom_styles/panel', unselect_style_box)

	match n:
		1:
			$ScrollContainer/VBoxContainer/calling_device_1.set('custom_styles/panel', cur_change_style_box)
			if game.main == null: return
			gamestate.state.current_equipment.calling_device = "1"
			game.equ_gui.update_calling_device()
			game.equ_hud.update_calling_device_hud()
		2:
			$ScrollContainer/VBoxContainer/calling_device_2.set('custom_styles/panel', cur_change_style_box)
			if game.main == null: return
			gamestate.state.current_equipment.calling_device = "2"
			game.equ_gui.update_calling_device()
			game.equ_hud.update_calling_device_hud()
			
func _on_calling_device_1_change_pressed():
	set_calling_device(1)
	
func _on_calling_device_2_change_pressed():
	set_calling_device(2)
