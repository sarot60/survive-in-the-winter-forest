extends Node2D

const rabbit = preload("res://props/animals/rabbit/rabbit.tscn")

var hole_number 

var player_in_hole = false

enum {
	FORAGING,
	RABBIT_DEATH,
	RABBIT_IN_HOLE
}

var state


func _ready():
	
	var _Con = get_node("player_detection").connect("body_entered", self ,"_on_player_detection_body_entered")
	var _Con1 = get_node("player_detection").connect("body_exited", self, "_on_player_detection_body_exited")
	
	get_hole_number()
	initiate()


func initiate():
	if hole_number == null:
		return
	if hole_number > 30 and hole_number < 1:
		return
	var status = gamestate.state.animal.rabbit_hole[str(hole_number)]
	if status == 1:
		state = FORAGING
	elif status == 0:
		state = RABBIT_IN_HOLE
	else:
		return
	set_rabbit()
	
func get_hole_number():
	hole_number = int(name.split("_")[2])

func set_rabbit():
	match state:
		FORAGING:
			load_rabbit()
		RABBIT_IN_HOLE:
			waiting_load()

func load_rabbit():
	var rabbit_obj = rabbit.instance()
	$rabbit_spawn.add_child(rabbit_obj)
	gamestate.state.animal.rabbit_hole[str(hole_number)] = 1
	
func waiting_load():
	$waiting_load_timer.set_wait_time(20)
	$waiting_load_timer.start()
	
func _rabbit_death_check():
	state = RABBIT_IN_HOLE
	gamestate.state.animal.rabbit_hole[str(hole_number)] = 0
	
func _rabbit_delete_check():
	set_rabbit()


# -----------------------------------------------------------------
# ---------------------------- Signal -----------------------------

func _on_player_detection_body_entered(body):
	if body.name == "player":
		player_in_hole = true
	
func _on_player_detection_body_exited(body):
	if body.name == "player":
		player_in_hole = false

func _on_waiting_load_timer_timeout():
	if player_in_hole == true:
		waiting_load()
	else:
		load_rabbit()
