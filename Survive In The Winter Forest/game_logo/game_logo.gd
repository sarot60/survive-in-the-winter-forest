extends CanvasLayer

func _on_Timer_timeout():
	game.main.load_screen( game.main.MENU_SCENE )
