extends Control

var is_shortcut_show = false

func _ready():
	hide()

func _input(event):
	if event.is_action_pressed("h"):
		if is_shortcut_show:
			hide()
			is_shortcut_show = false
		else:
			show()
			is_shortcut_show = true
		
