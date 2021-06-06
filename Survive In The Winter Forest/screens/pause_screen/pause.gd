extends Control

const MAINMENU_SCN = "res://screens/start_menu/start_menu.tscn"

func _ready():
	if game.main != null:
		$setting_dialog/music_volume.value = setting.setting_state.music_volume
		$setting_dialog/sfx_volume.value = setting.setting_state.sfx_volume
	set_process(false)

func _input(event):
	if event.is_action_pressed("pause"):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state

func _process(_delta):
	var newMusicVolume = $setting_dialog/music_volume.value
	var newSFXVolume = $setting_dialog/sfx_volume.value
	
	if setting.setting_state.music_volume != newMusicVolume:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), newMusicVolume)
		setting.setting_state.music_volume = newMusicVolume
		
	if setting.setting_state.sfx_volume != newSFXVolume:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), newSFXVolume)
		setting.setting_state.sfx_volume = newSFXVolume

func _on_resume_pressed():
	if game.main == null: return
	get_tree().paused = false
	visible = false

	set_process(false)


func _on_quit_pressed():
	if game.main == null: return
	game.main.load_screen( MAINMENU_SCN )
	
	setting.save_settingstate()

func _on_save_pressed():
	if game.main == null: return
	gamestate.pre_state_and_save()


func _on_setting_pressed():
	$setting_dialog.popup()
	if game.main != null:
		$setting_dialog/music_volume.value = setting.setting_state.music_volume
		$setting_dialog/sfx_volume.value = setting.setting_state.sfx_volume
	set_process(true)


func _on_save_setting_pressed():
	
#	var newMusicVolume = $setting_dialog/music_volume.value
#	var newSFXVolume = $setting_dialog/sfx_volume.value
#
#	print(newMusicVolume,".",newSFXVolume)
	
	setting.save_settingstate()
