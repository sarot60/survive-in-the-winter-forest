#extends Control
extends CanvasLayer

var item_no = null

const CREDIT_SCN = "res://screens/credit/credit.tscn"
const HELP_SCN = "res://screens/help/help.tscn"
const SETTINGS_SCN = "res://screens/settings/settings.tscn"

func _ready():
	
	#$menu/start_button.grab_focus()
	
	#if ( not gamestate.first_start ):
	#	print('is not first start')
		
	# ถ้ามีไฟล์ หรือเคยเซฟไว้
	if gamestate.check_gamestate_file():
		print('is loaded game')
		var _state = gamestate.load_gamestate()
		
		$menu/continue_button.disabled = false
		$menu/continue_button.focus_mode = 2
		
		$menu/continue_button/remove_save_game.disabled = false
		$menu/continue_button/remove_save_game.focus_mode = 2
	# ถ้าไม่มีคือต้องเริ่มเกมใหม่
	elif gamestate.first_start:
		print('is first start')
		$menu/continue_button.disabled = true
		$menu/continue_button.focus_mode = 0
		
		$menu/continue_button/remove_save_game.disabled = true
		$menu/continue_button/remove_save_game.focus_mode = 0
		
	if game.main != null:
	#	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), gamestate.state.music)
	#	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), gamestate.state.sfx)
		
		if !game.main.get_node("music").playing:
			game.main.music_fsm(0)
		

	$exit_alert.hide()
	$newgame_alert.hide()

""" --------------------------------------------------------------------
						method
-------------------------------------------------------------------- """

func _input(event):
	if event.is_action_pressed("btn_quit"):
		#quit_game()
		get_tree().quit()
		
		
func _on_selected_item(item_no_select):
	if game.main == null: return
	match item_no_select:
		0:
			# start a new game 
			show_alert_start_new_game()
		1:
			# continue game
			game.main.load_gamestate()

			print('continue game')
			#print(gamestate.state)
		2:
			# setting
			game.main.load_screen(SETTINGS_SCN)
		3:
			# help
			game.main.load_screen(HELP_SCN)
		4:
			# credit
			game.main.load_screen(CREDIT_SCN)
		5:
			# quit
			show_alert_quit_game()
	pass
		

func show_alert_start_new_game():
	$newgame_alert.show()
	$newgame_alert/AnimationPlayer.play("open")
	get_tree().paused = true
	
func start_new_game():
	gamestate.initiate()
	gamestate.first_start = false
	
	#print(gamestate.state)

	var _new = gamestate.save_gamestate()
	
	game.main.load_gamestate()


func show_alert_quit_game():
	$exit_alert.show()
	$exit_alert/AnimationPlayer.play("open")
	get_tree().paused = true

""" --------------------------------------------------------------------
						success method
-------------------------------------------------------------------- """



""" --------------------------------------------------------------------
								signal
-------------------------------------------------------------------- """

func _on_start_button_pressed():
	_on_selected_item(0)

func _on_continue_button_pressed():
	_on_selected_item(1)

func _on_setting_button_pressed():
	_on_selected_item(2)

func _on_help_button_pressed():
	_on_selected_item(3)
	
func _on_credit_button_pressed():
	_on_selected_item(4)

func _on_quit_pressed():
	_on_selected_item(5)


func _on_alert_exit_cancle_pressed():
	$exit_alert/AnimationPlayer.play("close")
	get_tree().paused = false
	
func _on_alert_exit_confirm_pressed():
	get_tree().quit()


func _on_alert_newgame_confirm_pressed():
	start_new_game()
	get_tree().call_group("start_game_check", "game_start", true)
	print('start game')


func _on_alert_newgame_cancle_pressed():
	$newgame_alert/AnimationPlayer.play("close")
	get_tree().paused = false


func _on_light_timer_timeout():
	var x = rand_range(1,2)
	$props/fire_menu/Tween.interpolate_property($props/fire_menu/light, "scale",
	Vector2(1, 1), Vector2(x, x), 2,
	$props/fire_menu/Tween.TRANS_LINEAR, $props/fire_menu/Tween.EASE_IN)
	
	$props/fire_menu/Tween.start()


#---------------------------- mouse extered ------------------------------------------------

func _on_start_button_mouse_entered():
	$menu/start_button/Sprite.show()
func _on_start_button_mouse_exited():
	$menu/start_button/Sprite.hide()


func _on_continue_button_mouse_entered():
	$menu/continue_button/Sprite.show()
func _on_continue_button_mouse_exited():
	$menu/continue_button/Sprite.hide()
	
	
func _on_setting_button_mouse_entered():
	$menu/setting_button/Sprite.show()
func _on_setting_button_mouse_exited():
	$menu/setting_button/Sprite.hide()


func _on_help_button_mouse_entered():
	$menu/help_button/Sprite.show()
func _on_help_button_mouse_exited():
	$menu/help_button/Sprite.hide()
	
	
func _on_credit_button_mouse_entered():
	$menu/credit_button/Sprite.show()
func _on_credit_button_mouse_exited():
	$menu/credit_button/Sprite.hide()
	
	
func _on_quit_mouse_entered():
	$menu/quit/Sprite.show()
func _on_quit_mouse_exited():
	$menu/quit/Sprite.hide()


# --------------
func _on_remove_save_game_pressed():
	var suc = gamestate.remove_gamestate_file()
	if suc:
		gamestate.first_start = true
		gamestate.initiate()
		$menu/continue_button.disabled = true
		$menu/continue_button.focus_mode = 0
		
		$menu/continue_button/remove_save_game.disabled = true
		$menu/continue_button/remove_save_game.focus_mode = 0


