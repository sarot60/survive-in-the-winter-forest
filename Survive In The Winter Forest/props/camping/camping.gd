extends YSort


func _ready():
	for i in get_node("tent/tent_dialog").get_children():
		var _x = i.connect("mouse_entered", self, "_on_check_mouse_panel_entered")
		var _y = i.connect("mouse_exited", self, "_on_check_mouse_panel_exited")
		
		
# ------------------------ Signals ---------------------------


func _on_player_detection_body_entered(body):
	if body.name == "player":
		get_node("tent/tent_dialog").show()


func _on_player_detection_body_exited(body):
	if body.name == "player":
		get_node("tent/tent_dialog").hide()
	
	check.mouse_on_gui = false
	
# เก็บเต๊น
func _on_Button_pressed():
	gamestate.state.camping.set_up_a_camp = 0
	gamestate.state.camping.camp_pos = []
	queue_free()
	
	check.mouse_on_gui = false


# นอนๆ
func _on_sleep_button_pressed():
	
	var current_time = gamestate.state.time_seconds
	
	if current_time > 265 or (current_time >= 0 and current_time < 70):
		if game.main == null: return
		game.clock.sleep_update()
		game.main_map.delete_wolf()
		
	else:
		game.text_alert.add_data_to_play("ไม่สามารถนอนตอนนี้ได้ ! ! !")
		#print('can not sleep')

func _on_check_mouse_panel_entered():
	check.mouse_on_gui = true

func _on_check_mouse_panel_exited():
	check.mouse_on_gui = false
