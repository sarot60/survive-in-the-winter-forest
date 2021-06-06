extends Control
#extends CanvasLayer

var player = null

func _ready():
	set_process(false)
	add_to_group("need_player_ref")
	
func _process(_delta):
	$FPS.text = str(Performance.get_monitor(Performance.TIME_FPS)) + "FPS"
	if player != null:
		$player_position.text = 'player position \nx='+str(player.global_position.x)+'\ny='+str(player.global_position.y)

func set_player(p):
	player = p
	if player != null:
		set_process(true)
