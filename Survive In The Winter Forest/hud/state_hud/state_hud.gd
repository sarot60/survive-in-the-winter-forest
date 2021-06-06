extends Control

var state = 0
var prev_state = 0

func _ready():
	update_hud()

func _process(_delta):
	if game.player == null:
		return
	state = game.player.state
	update_hud()
	prev_state = state
	
	if game.player.player_in_props:
		$can_calling/cannot.hide()
	else:
		$can_calling/cannot.show()

func update_hud():
	match prev_state:
		0:
			$background/idle.visible = false
		1:
			$background/move.visible = false
		2:
			$background/sit.visible = false
			
	match state:
		0:
			$background/idle.visible = true
		1:
			$background/move.visible = true
		2:
			$background/sit.visible = true
			
	#if state != 0 and state != 1 and state != 2:
	#	match prev_state:
	#		0:
	#			$idle.visible = true
	#		1:
	#			$move.visible = true
	#		2:
	#			$sit.visible = true

func set_can_calling():
	if game.player == null: return
	
	if game.player.player_in_props:
		$can_calling/cannot.hide()
	else:
		$can_calling/cannot.show()
