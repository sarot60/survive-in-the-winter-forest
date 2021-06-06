extends Panel



func _ready():
	
	var _tmp31 = connect("mouse_entered", self, "_on_check_mouse_panel_entered")
	var _tmp22 = connect("mouse_exited", self, "_on_check_mouse_panel_exited")
	
	for i in get_children():
		var _tmp = i.connect("mouse_entered", self, "_on_check_mouse_panel_entered")
		var _tmp2 = i.connect("mouse_exited", self, "_on_check_mouse_panel_exited")


# ---------------------------- Signal ---------------------------
func _on_check_mouse_panel_entered():
	check.mouse_on_gui = true

func _on_check_mouse_panel_exited():
	check.mouse_on_gui = false


func _on_morning_pressed():
	if game.main == null: return
	
	game.clock.gm_set_day("morning")


func _on_evening_pressed():
	if game.main == null: return
	
	game.clock.gm_set_day("evening")


func _on_noon_pressed():
	if game.main == null: return
	
	game.clock.gm_set_day("noon")
