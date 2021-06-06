extends Control

var reducation_food_rate = 2
var reducation_water_rate = 3

var reducation_food = 0
var reducation_water = 0

var death = false

func _ready():
	game.hp_food_water_bar = self
	add_to_group("clock_update")
	
	
func _process(delta):
	
	if !death:
		
		# การลดลงของอาหาร
		if gamestate.state.food > 0:
			reducation_food += delta
			if reducation_food > reducation_food_rate:
				reducation_food = 0
				gamestate.state.food -= 2
				var _f = gamestate.state.food
				$VBoxContainer/food/TextureProgress.value = _f
				
				if gamestate.state.food < 0:
					gamestate.state.food = 0
					
		# ลดเลือด
		elif gamestate.state.food <= 0:
			reducation_food += delta
			if reducation_food > reducation_food_rate:
				reducation_food = 0
				gamestate.state.health -= 2
				var _f = gamestate.state.health
				$VBoxContainer/health/TextureProgress.value = _f
				
				if gamestate.state.health < 0:
					gamestate.state.health = 0
				
				if gamestate.state.health <= 0:
					death = true
					game.player.reborn()
					
		# การลดลงของน้ำ
		if gamestate.state.water > 0:
			reducation_water += delta
			if reducation_water > reducation_water_rate:
				reducation_water = 0
				gamestate.state.water -= 2
				var _w = gamestate.state.water
				$VBoxContainer/water/TextureProgress.value = _w
				
				if gamestate.state.water < 0:
					gamestate.state.water = 0
					
		# ลดเลือด
		elif gamestate.state.water <= 0:
			reducation_water += delta
			if reducation_water > reducation_water_rate:
				reducation_water = 0
				gamestate.state.health -= 2
				var _w = gamestate.state.health
				$VBoxContainer/health/TextureProgress.value = _w
				
				if gamestate.state.health < 0:
					gamestate.state.health = 0
					
				if gamestate.state.health <= 0:
					death = true
					game.player.reborn()
			
		
func update_hud_day():
	if game.main == null: return
	var _tmpStr = ""
	_tmpStr = _tmpStr + "Survival Day " + str(gamestate.state.day) + "\n"
	_tmpStr = _tmpStr + "Level " + str(gamestate.state.level)
	$survival_detail/day.text = _tmpStr
	
func update_bar():
	if game.main == null: return
	
	$VBoxContainer/health/TextureProgress.value = gamestate.state.health
	$VBoxContainer/food/TextureProgress.value = gamestate.state.food
	$VBoxContainer/water/TextureProgress.value = gamestate.state.water
	
	
	pass
	
func initiate():
	#if game.main == null: return
	
	$VBoxContainer/health/TextureProgress.value = gamestate.state.health
	$VBoxContainer/food/TextureProgress.value = gamestate.state.food
	$VBoxContainer/water/TextureProgress.value = gamestate.state.water
	
	update_hud_day()


