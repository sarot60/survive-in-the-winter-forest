extends Node

# gdscrip module
var rng = RandomNumberGenerator.new()

var zone


func get_zone(p):
	if p.x >= -5000 and p.y >= -5000 and p.x <= 0 and p.y <= 0:
		## A1
		## X- Y-
		zone = "A1"
	elif p.x >= -5000 and p.y >= -10000 and p.x <= 0 and p.y <= -5000:
		## A2
		## X- Y-
		zone = "A2"
	elif p.x >= -10000 and p.y >= -10000 and p.x <= -5000 and p.y <= -5000:
		## A3
		## X- Y-
		zone = "A3"
	elif p.x >= -10000 and p.y >= -5000 and p.x <= -5000 and p.y <= 0:
		## A4
		## X- Y-
		zone = "A4"
		
		
	elif p.x >= 0 and p.y >= -5000 and p.x <= 5000 and p.y <= 0:
		## B1
		## X+ Y-
		zone = "B1"
	elif p.x >= 0 and p.y >= -10000 and p.x <= 5000 and p.y <= -5000:
		## B2
		## X+ Y-
		zone = "B2"
	elif p.x >= 5000 and p.y >= -10000 and p.x <= 10000 and p.y <= -5000:
		## B3
		## X+ Y-
		zone = "B3"
	elif p.x >= 5000 and p.y >= -5000 and p.x <= 10000 and p.y <= 0:
		## B4
		## X+ Y-
		zone = "B4"
		
	
	elif p.x >= -5000 and p.y >= 0 and p.x <= 0 and p.y <= 5000:
		## C1
		## X- Y+
		zone = "C1"
	elif p.x >= -5000 and p.y >= 5000 and p.x <= 0 and p.y <= 10000:
		## C2
		## X- Y+
		zone = "C2"
	elif p.x >= -10000 and p.y >= 5000 and p.x <= -5000 and p.y <= 10000:
		## C3
		## X- Y+
		zone = "C3"
	elif p.x >= -10000 and p.y >= 0 and p.x <= -5000 and p.y <= 5000:
		## C4
		## X- Y+
		zone = "C4"
		
		
	elif p.x >= 0 and p.y >= 0 and p.x <= 5000 and p.y <= 5000:
		## D1
		## X+ Y+
		zone = "D1"
	elif p.x >= 0 and p.y >= 5000 and p.x <= 5000 and p.y <= 10000:
		## D2
		## X+ Y+
		zone = "D2"
	elif p.x >= 5000 and p.y >= 5000 and p.x <= 10000 and p.y <= 10000:
		## D4
		## X+ Y+
		zone = "D3"
	elif p.x >= 5000 and p.y >= 0 and p.x <= 10000 and p.y <= 5000:
		## D4
		## X+ Y+
		zone = "D4"
		
		
	else:
		zone = null

func get_pos_center_zone():
	pass

func random_move(z):
	match z[0]:
		"A":
			match z:
				"A1":
					rng.randomize()
					var x_foraging_rand = round(rng.randf_range(1000,5000))
					rng.randomize()
					var y_foraging_rand = round(rng.randf_range(1000,5000))
					return Vector2(-x_foraging_rand, -y_foraging_rand)
				"A2":
					rng.randomize()
					var x_foraging_rand = round(rng.randf_range(1,5000))
					rng.randomize()
					var y_foraging_rand = round(rng.randf_range(5000,10000))
					return Vector2(-x_foraging_rand, -y_foraging_rand)
				"A3":
					rng.randomize()
					var x_foraging_rand = round(rng.randf_range(5000,10000))
					rng.randomize()
					var y_foraging_rand = round(rng.randf_range(5000,10000))
					return Vector2(-x_foraging_rand, -y_foraging_rand)
				"A4":
					rng.randomize()
					var x_foraging_rand = round(rng.randf_range(5000,10000))
					rng.randomize()
					var y_foraging_rand = round(rng.randf_range(1,5000))
					return Vector2(-x_foraging_rand, -y_foraging_rand)
				_:
					return Vector2(1000,5000)
		"B":
			match z:
				"B1":
					rng.randomize()
					var x_foraging_rand = round(rng.randf_range(1000,5000))
					rng.randomize()
					var y_foraging_rand = round(rng.randf_range(1000,5000))
					return Vector2(x_foraging_rand, -y_foraging_rand)
				"B2":
					rng.randomize()
					var x_foraging_rand = round(rng.randf_range(1,5000))
					rng.randomize()
					var y_foraging_rand = round(rng.randf_range(5000,10000))
					return Vector2(x_foraging_rand, -y_foraging_rand)
				"B3":
					rng.randomize()
					var x_foraging_rand = round(rng.randf_range(5000,10000))
					rng.randomize()
					var y_foraging_rand = round(rng.randf_range(5000,10000))
					return Vector2(x_foraging_rand, -y_foraging_rand)
				"B4":
					rng.randomize()
					var x_foraging_rand = round(rng.randf_range(5000,10000))
					rng.randomize()
					var y_foraging_rand = round(rng.randf_range(1,5000))
					return Vector2(x_foraging_rand, -y_foraging_rand)
				_:
					return Vector2(1000,5000)
		"C":
			match z:
				"C1":
					rng.randomize()
					var x_foraging_rand = round(rng.randf_range(1000,5000))
					rng.randomize()
					var y_foraging_rand = round(rng.randf_range(1000,5000))
					return Vector2(-x_foraging_rand, y_foraging_rand)
				"C2":
					rng.randomize()
					var x_foraging_rand = round(rng.randf_range(1,5000))
					rng.randomize()
					var y_foraging_rand = round(rng.randf_range(5000,10000))
					return Vector2(-x_foraging_rand, y_foraging_rand)
				"C3":
					rng.randomize()
					var x_foraging_rand = round(rng.randf_range(5000,10000))
					rng.randomize()
					var y_foraging_rand = round(rng.randf_range(5000,10000))
					return Vector2(-x_foraging_rand, y_foraging_rand)
				"C4":
					rng.randomize()
					var x_foraging_rand = round(rng.randf_range(5000,10000))
					rng.randomize()
					var y_foraging_rand = round(rng.randf_range(1,5000))
					return Vector2(-x_foraging_rand, y_foraging_rand)
				_:
					return Vector2(1000,5000)
		"D":
			match z:
				"D1":
					rng.randomize()
					var x_foraging_rand = round(rng.randf_range(1000,5000))
					rng.randomize()
					var y_foraging_rand = round(rng.randf_range(1000,5000))
					return Vector2(x_foraging_rand, y_foraging_rand)
				"D2":
					rng.randomize()
					var x_foraging_rand = round(rng.randf_range(1,5000))
					rng.randomize()
					var y_foraging_rand = round(rng.randf_range(5000,10000))
					return Vector2(x_foraging_rand, y_foraging_rand)
				"D3":
					rng.randomize()
					var x_foraging_rand = round(rng.randf_range(5000,10000))
					rng.randomize()
					var y_foraging_rand = round(rng.randf_range(5000,10000))
					return Vector2(x_foraging_rand, y_foraging_rand)
				"D4":
					rng.randomize()
					var x_foraging_rand = round(rng.randf_range(5000,10000))
					rng.randomize()
					var y_foraging_rand = round(rng.randf_range(1,5000))
					return Vector2(x_foraging_rand, y_foraging_rand)
				_:
					return Vector2(1000,5000)
		
func animals_escape():
	if zone == null:
		return
	if game.player == null:
		return
	
	
	

