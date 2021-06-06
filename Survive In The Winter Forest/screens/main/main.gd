#extends Node2D
extends Node

const MENU_SCENE = "res://screens/start_menu/start_menu.tscn"
const FIRST_SCENE = "res://game_logo/game_logo.tscn"

const MAIN_SCENE = "res://maps/main_map/main_map.tscn"

""" --------------------------------------------------------------------
							method
-------------------------------------------------------------------- """

var music_state = 0

func _ready():
	game.main = self
	load_screen(FIRST_SCENE)
	
	if setting.check_settingstate_file():
		var _state = setting.load_settingstate()
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), setting.setting_state.music_volume)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), setting.setting_state.sfx_volume)
#		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), setting.setting_state.music)
#		AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), setting.setting_state.sfx)
	else:
		#print(setting.setting_state)
		#print('is new setting state')
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), setting.setting_state.music_volume)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), setting.setting_state.sfx_volume)
#		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), setting.setting_state.music)
#		AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), setting.setting_state.sfx)
	

#==================================
# Load Screen
#==================================
var load_state = 0
var cur_screen
func load_screen( scrn := "" ):
	if not scrn.empty():
		load_state = 0
		cur_screen = scrn
	match load_state:
		0:
			print(load_state)
			print( "LOADING SCREEN: ", cur_screen )
			get_tree().paused = true
			# add fade
			if cur_screen != "res://screens/credit/credit.tscn" \
				and cur_screen != "res://screens/start_menu/start_menu.tscn" \
				and cur_screen != "res://screens/help/help.tscn" \
				and cur_screen != "res://screens/settings/settings.tscn":
				$fade_layer/fade_bg.show()
			$fade_layer/AnimationPlayer.play("fade_1")
			load_state = 1
			$screentimer.set_wait_time( 0.2 )
			$screentimer.start()
		1:
			print(load_state)
			$hud_layer/hud.hide()
			$gui_layer/gui.hide()
			var children = $game.get_children()
			if not children.empty():
				children[0].queue_free()
			load_state = 2
			$screentimer.set_wait_time( 0.05 )
			$screentimer.start()
		2:
			print(load_state)
			var new_level = load( cur_screen ).instance()
			$game.add_child( new_level )
			load_state = 3
			$screentimer.set_wait_time( 0.3 )
			$screentimer.start()
		3:
			print(load_state)
			# add fade
			$fade_layer/fade_bg.hide()
			$fade_layer/AnimationPlayer.play("fade_2")
			load_state = 4
			$screentimer.set_wait_time( 0.2 )
			$screentimer.start()
		4:
			print(load_state)
			$pause_layer/pause.visible = false
			get_tree().paused = false
			load_state = 0
#==================================
# End Load Screen
#==================================


#==================================
# Load GameState
#==================================
func load_gamestate():
	match load_state:
		0:
			print( "LOADING STAGE: ", MAIN_SCENE )
			get_tree().paused = true
			# add fade
			$fade_layer/AnimationPlayer.play("fade_1")
			load_state = 1
			$loadtimer.set_wait_time( 0.2 )
			$loadtimer.start()
		1:
			$hud_layer/hud.hide()
			$gui_layer/gui.hide()
			var children = $game.get_children()
			if not children.empty():
				children[0].queue_free()
			load_state = 2
			$loadtimer.set_wait_time( 0.05 )
			$loadtimer.start()
		2:
			var new_level = load(MAIN_SCENE).instance()
			$game.add_child( new_level )
			get_tree().paused = false
			#$hud_layer/hud/game_map.call_deferred( "_update_map" )
			
			set_hudgui_before_start()
			
			$hud_layer/hud.show()
			#$gui_layer/gui.show()
			
			load_state = 3
			$loadtimer.set_wait_time( 0.3 )
			$loadtimer.start()
		3:
			# add fade
			$fade_layer/AnimationPlayer.play("fade_2")
			load_state = 4
			$loadtimer.set_wait_time( 0.2 )
			$loadtimer.start()
		4:
			
			load_state = 0
#==================================
# End Load GameState
#==================================

func set_hudgui_before_start():
	#pre data in hud and gui
	
	if game.main == null: return
	
	# hud
	game.hp_food_water_bar.initiate()
	game.equ_hud.initiate()
	game.clock.initiate()
	#if has_node("hud_layer/hud/current_quest"):
	#	get_node("hud_layer/hud/current_quest/").initiate()
	if game.hud.has_node("current_quest"):
		game.hud.get_node("current_quest").initiate()

	
	# gui
	game.gui.initiate()
	#game.b_menu.initiate()
	game.inventory.initiate()
	game.perk.initiate()
	game.equ_gui.initiate()
	game.quest.initiate()
	game.player_detail.initiate()
	
""" --------------------------------------------------------------------
						success method
-------------------------------------------------------------------- """

const wind_music = preload("res://music/from_soundbible/Wind-Mark_DiAngelo-1940285615.wav")
const main_menu_music = preload("res://music/soundimage_dot_org/Lost-Jungle_Looping.wav")

func music_fsm(s):

	match s:
		0:
			$music.stream = main_menu_music
			$music.play(1)
			music_state = 0
		1:	
			$music.stream = wind_music
			$music.play(1)
			music_state = 1

func _exit_tree():
	print("Exit Game")
	#EmptyInvItem.free()


""" --------------------------------------------------------------------
						signal
-------------------------------------------------------------------- """

func _on_music_finished():
	music_fsm(music_state)


func _on_screentimer_timeout():
	load_screen()


func _on_loadtimer_timeout():
	load_gamestate()
