#extends CanvasLayer
#extends Node2D
#extends Node
extends Control

onready var slider = get_node("graphic/HSlider")
onready var timer = get_node("graphic/Timer")

onready var day_night_canvas = get_node("day_night_canvas")

var sleep = false
var initiatal_make_wolf = false

func _ready():
	game.clock = self
	timer.stop()
	#add_to_group("start_game_check")
	
func game_start(_s):
	slider.value = gamestate.state.time_seconds
	#slider.value = 150
	#print(slider.value)
	
	# set canvas from load from gamestate
	if slider.value >= 0 and slider.value <= 28:
		day_night_canvas.set_color(Color(0.44, 0.44, 0.44, 1.0))
		
	elif slider.value >= 36 and slider.value <= 52:
		day_night_canvas.set_color(Color(0.54, 0.54, 0.54, 1.0))
	elif slider.value >= 56 and slider.value <= 72:
		day_night_canvas.set_color(Color(0.64, 0.64, 0.64, 1.0))
		
	elif slider.value >= 74 and slider.value <= 90:
		day_night_canvas.set_color(Color(0.74, 0.74, 0.74, 1.0))
	elif slider.value >= 94 and slider.value <= 110:
		day_night_canvas.set_color(Color(0.84, 0.84, 0.84, 1.0))
		
	elif slider.value >= 112 and slider.value <= 128:
		day_night_canvas.set_color(Color(0.92, 0.92, 0.92, 1.0))
	elif slider.value >= 132 and slider.value <= 148:
		day_night_canvas.set_color(Color(0.97, 0.97, 0.97, 1.0))
		
	elif slider.value >= 150 and slider.value <= 166:
		day_night_canvas.set_color(Color(0.98, 0.98, 0.98, 1.0))
	elif slider.value >= 170 and slider.value <= 186:
		day_night_canvas.set_color(Color(0.93, 0.93, 0.93, 1.0))
		
	elif slider.value >= 188 and slider.value <= 204:
		day_night_canvas.set_color(Color(0.86, 0.86, 0.86, 1.0))
	elif slider.value >= 208 and slider.value <= 224:
		day_night_canvas.set_color(Color(0.76, 0.76, 0.76, 1.0))
		
	elif slider.value >= 226 and slider.value <= 242:
		day_night_canvas.set_color(Color(0.66, 0.66, 0.66, 1.0))
	elif slider.value >= 246 and slider.value <= 262:
		day_night_canvas.set_color(Color(0.56, 0.56, 0.56, 1.0))
		
	elif slider.value >= 264 and slider.value <= 292:
		day_night_canvas.set_color(Color(0.46, 0.46, 0.46, 1.0))
		
	set_canvas(slider.value)
	timer.set_wait_time(1)
	timer.start()


func set_to_0_am():
	gamestate.state.time_seconds = 0
	slider.value = gamestate.state.time_seconds
	gamestate.state.day += 1
	if gamestate.state.day > gamestate.state.max_survival_day:
		gamestate.state.max_survival_day = gamestate.state.day
	#get_tree().call_group("clock_update", "update_day", gamestate.state.day)
	
	game.hp_food_water_bar.update_hud_day()
	
func sleep_update():
	var current_time = gamestate.state.time_seconds
	
	if current_time > 265:
		gamestate.state.day += 1
		if gamestate.state.day > gamestate.state.max_survival_day:
			gamestate.state.max_survival_day = gamestate.state.day
			
		game.hp_food_water_bar.update_hud_day()
		
	gamestate.state.time_seconds = 71
	slider.value = gamestate.state.time_seconds
	
	#set_canvas(72)
	day_night_canvas.set_color(Color(0.68, 0.68, 0.68, 1.0))
	
	
func set_canvas(t):
	match t:
		### ===================== start AM =======================
		### range 00.00 AM
		0.0:
			day_night_canvas.set_color(Color(0.4, 0.4, 0.4, 1.0))
		7.0:
			day_night_canvas.set_color(Color(0.42, 0.42, 0.42, 1.0))
		14.0:
			day_night_canvas.set_color(Color(0.44, 0.44, 0.44, 1.0))
		21.0:
			day_night_canvas.set_color(Color(0.46, 0.46, 0.46, 1.0))
		28.0:
			day_night_canvas.set_color(Color(0.48, 0.48, 0.48, 1.0))
		
		### range 3.00 AM
		36.0:
			day_night_canvas.set_color(Color(0.5, 0.5, 0.5, 1.0))
		40.0:
			day_night_canvas.set_color(Color(0.52, 0.52, 0.52, 1.0))
		44.0:
			day_night_canvas.set_color(Color(0.54, 0.54, 0.54, 1.0))
		48.0:
			day_night_canvas.set_color(Color(0.56, 0.56, 0.56, 1.0))
		52.0:
			day_night_canvas.set_color(Color(0.58, 0.58, 0.58, 1.0))
		56.0:
			day_night_canvas.set_color(Color(0.6, 0.6, 0.6, 1.0))
		60.0:
			day_night_canvas.set_color(Color(0.62, 0.62, 0.62, 1.0))
		64.0:
			day_night_canvas.set_color(Color(0.64, 0.64, 0.64, 1.0))
		68.0:
			day_night_canvas.set_color(Color(0.66, 0.66, 0.66, 1.0))
		72.0:
			day_night_canvas.set_color(Color(0.68, 0.68, 0.68, 1.0))
		
		### range 6.00 AM
		74.0:
			day_night_canvas.set_color(Color(0.7, 0.7, 0.7, 1.0))
		78.0:
			day_night_canvas.set_color(Color(0.72, 0.72, 0.72, 1.0))
		82.0:
			day_night_canvas.set_color(Color(0.74, 0.74, 0.74, 1.0))
		86.0:
			day_night_canvas.set_color(Color(0.76, 0.76, 0.76, 1.0))
		90.0:
			day_night_canvas.set_color(Color(0.78, 0.78, 0.78, 1.0))
		94.0:
			day_night_canvas.set_color(Color(0.8, 0.8, 0.8, 1.0))
		98.0:
			day_night_canvas.set_color(Color(0.82, 0.82, 0.82, 1.0))
		102.0:
			day_night_canvas.set_color(Color(0.84, 0.84, 0.84, 1.0))
		106.0:
			day_night_canvas.set_color(Color(0.86, 0.86, 0.86, 1.0))
		110.0:
			day_night_canvas.set_color(Color(0.88, 0.88, 0.88, 1.0))
			
		### range 9.00 AM
		112.0:
			day_night_canvas.set_color(Color(0.9, 0.9, 0.9, 1.0))
		116.0:
			day_night_canvas.set_color(Color(0.91, 0.91, 0.91, 1.0))
		120.0:
			day_night_canvas.set_color(Color(0.92, 0.92, 0.92, 1.0))
		124.0:
			day_night_canvas.set_color(Color(0.93, 0.93, 0.93, 1.0))
		128.0:
			day_night_canvas.set_color(Color(0.94, 0.94, 0.94, 1.0))
		132.0:
			day_night_canvas.set_color(Color(0.95, 0.95, 0.95, 1.0))
		136.0:
			day_night_canvas.set_color(Color(0.96, 0.96, 0.96, 1.0))
		140.0:
			day_night_canvas.set_color(Color(0.97, 0.97, 0.97, 1.0))
		144.0:
			day_night_canvas.set_color(Color(0.98, 0.98, 0.98, 1.0))
		148.0:
			day_night_canvas.set_color(Color(0.99, 0.99, 0.99, 1.0))
			
		### ===================== end AM ========================
		
		### start game day 
		### ================== start PM =========================
		### 00.00 PM
		150.0:
			day_night_canvas.set_color(Color(1.0, 1.0, 1.0, 1.0))
		154.0:
			day_night_canvas.set_color(Color(0.99, 0.99, 0.99, 1.0))
		158.0:
			day_night_canvas.set_color(Color(0.98, 0.98, 0.98, 1.0))
		162.0:
			day_night_canvas.set_color(Color(0.97, 0.97, 0.97, 1.0))
		166.0:
			day_night_canvas.set_color(Color(0.96, 0.96, 0.96, 1.0))
		170.0:
			day_night_canvas.set_color(Color(0.95, 0.95, 0.95, 1.0))
		174.0:
			day_night_canvas.set_color(Color(0.94, 0.94, 0.94, 1.0))
		178.0:
			day_night_canvas.set_color(Color(0.93, 0.93, 0.93, 1.0))
		182.0:
			day_night_canvas.set_color(Color(0.92, 0.92, 0.92, 1.0))
		186.0:
			day_night_canvas.set_color(Color(0.91, 0.91, 0.91, 1.0))
			
		### range 3.00 PM
		188.0:
			day_night_canvas.set_color(Color(0.9, 0.9, 0.9, 1.0))
		192.0:
			day_night_canvas.set_color(Color(0.88, 0.88, 0.88, 1.0))
		196.0:
			day_night_canvas.set_color(Color(0.86, 0.86, 0.86, 1.0))
		200.0:
			day_night_canvas.set_color(Color(0.84, 0.84, 0.84, 1.0))
		204.0:
			day_night_canvas.set_color(Color(0.82, 0.82, 0.82, 1.0))
		208.0:
			day_night_canvas.set_color(Color(0.8, 0.8, 0.8, 1.0))
		212.0:
			day_night_canvas.set_color(Color(0.78, 0.78, 0.78, 1.0))
		216.0:
			day_night_canvas.set_color(Color(0.76, 0.76, 0.76, 1.0))
		220.0:
			day_night_canvas.set_color(Color(0.74, 0.72, 0.72, 1.0))
		224.0:
			day_night_canvas.set_color(Color(0.72, 0.72, 0.72, 1.0))
			
		### range 6.00 PM
		226.0:
			day_night_canvas.set_color(Color(0.7, 0.7, 0.7, 1.0))
		230.0:
			day_night_canvas.set_color(Color(0.68, 0.68, 0.68, 1.0))
		234.0:
			day_night_canvas.set_color(Color(0.66, 0.66, 0.66, 1.0))
		238.0:
			day_night_canvas.set_color(Color(0.64, 0.64, 0.64, 1.0))
		242.0:
			day_night_canvas.set_color(Color(0.62, 0.62, 0.62, 1.0))
		246.0:
			day_night_canvas.set_color(Color(0.6, 0.6, 0.6, 1.0))
		250.0:
			day_night_canvas.set_color(Color(0.58, 0.58, 0.58, 1.0))
		254.0:
			day_night_canvas.set_color(Color(0.56, 0.56, 0.56, 1.0))
		258.0:
			day_night_canvas.set_color(Color(0.54, 0.54, 0.54, 1.0))
		262.0:
			day_night_canvas.set_color(Color(0.52, 0.52, 0.52, 1.0))
		
		### range 9.00 PM
		264.0:
			day_night_canvas.set_color(Color(0.5, 0.5, 0.5, 1.0))
		271.0:
			day_night_canvas.set_color(Color(0.48, 0.48, 0.48, 1.0))
		278.0:
			day_night_canvas.set_color(Color(0.46, 0.46, 0.46, 1.0))
		285.0:
			day_night_canvas.set_color(Color(0.44, 0.44, 0.44, 1.0))
		292.0:
			day_night_canvas.set_color(Color(0.42, 0.42, 0.42, 1.0))
		
		### ===================== end PM =======================
		
		#_:
		#	print("It's not match")
func initiate():
	
	var current_time = gamestate.state.time_seconds
	
	# make wolf
	if current_time > 265 or current_time >= 0 and current_time < 70:
		game.main_map.make_wolf()
	
	game_start(true)
	
	pass
	
func gm_set_day(type:String):
	match type:
		"morning":
			if gamestate.state.time_seconds > 265 or gamestate.state.time_seconds < 70:
				game.main_map.delete_wolf()
			
			day_night_canvas.set_color(Color(0.7, 0.7, 0.7, 1.0))
			gamestate.state.time_seconds = 72
			
		"evening":
			if gamestate.state.time_seconds < 265 or gamestate.state.time_seconds > 70:
				game.main_map.make_wolf()
				
			day_night_canvas.set_color(Color(0.5, 0.5, 0.5, 1.0))
			gamestate.state.time_seconds = 269
			
			
		"noon":
			if gamestate.state.time_seconds > 265 or gamestate.state.time_seconds < 70:
				game.main_map.delete_wolf()
				
			day_night_canvas.set_color(Color(0.9, 0.9, 0.9, 1.0))
			gamestate.state.time_seconds = 186
	
# --------------------------- Signal -----------------------------
	
func _on_Timer_timeout():
	set_canvas(slider.value)
	gamestate.state.time_seconds += 1
	slider.value = gamestate.state.time_seconds

	
	if slider.value >= 300:
		set_to_0_am()
	
	if slider.value == 265:
		game.main_map.make_wolf()
		
	if slider.value == 70:
		game.main_map.delete_wolf()
	
	# make wolf
	
