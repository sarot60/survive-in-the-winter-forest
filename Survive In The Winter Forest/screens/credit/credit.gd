extends CanvasLayer

const MENU_SCN = "res://screens/start_menu/start_menu.tscn"


func _on_back_pressed():
	if game.main == null: return
	game.main.load_screen(MENU_SCN)
