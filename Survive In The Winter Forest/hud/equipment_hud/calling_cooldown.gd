extends TextureRect

export var cooldown = 10.0

func _ready():
	$Label.hide()
	$cooldown_display.value = 0
	$cooldown_display.texture_progress = load("res://assets/other/white-64x64.png")
	$Timer.wait_time = cooldown
	set_process(false)
	
func _process(_delta):
	$Label.text = "%3.1f" % $Timer.time_left
	$cooldown_display.value = int(($Timer.time_left / cooldown) * 100)

func start_cooldown():
	set_process(true)
	self_modulate = Color(0.2, 0.2, 0.2, 1)
	$TextureRect.self_modulate = Color(0.5, 0.5, 0.5, 1)
	$Timer.start()
	$Label.show()

func _on_Timer_timeout():
	$cooldown_display.value = 0
	$Label.hide()
	set_process(false)
	self_modulate = Color(0, 0, 0, 1)
	$TextureRect.self_modulate = Color(1, 1, 1, 1)
	
	if game.player != null:
		game.player.can_calling = true

