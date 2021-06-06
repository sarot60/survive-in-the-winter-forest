extends KinematicBody2D

signal health_update(health)
signal killed()

#const ACCELERATION = 5000 # change from 500
#const MAX_SPEED = 2000 # change from 80
#const FRICTION = 5000 # change from 500

const step1 = preload("res://assets/sfx/footstep1.wav")
const step2 = preload("res://assets/sfx/footstep2.wav")
const step3 = preload("res://assets/sfx/footstep3.wav")
const STEP_RATE = 80 # change from 30
var cur_step_dist = 0
const footstep = preload("res://effects/foot_step/foot_step.tscn")

var is_move = false

#var ACCELERATION = 1000
#var MAX_SPEED = 300
#var FRICTION = 750

var velocity = Vector2.ZERO

const RELOAD_TIME = 2.0
var time_spent_reloading = 0
var reloading = false
var facing_right = false
var gun_facing_right = false

var time_spent_muzzle_flash = 0

# ---------------------------- Guns ------------------------------------
# pistol
var pistol_is_shoot = false
var time_spent_pistol_muzzle_flash = 0
var time_spent_pistol_chane_the_mag = 0
# sniper
var time_spent_sniper_chane_the_mag = 0
# sniper and pistol
var change_the_mag = false

# --------------------------- Knife ---------------------------------
var time_spent_knife_attack = 0
var knife_attack = false

# --------------------------- Shovel ----------------------------------
var time_spent_shovel_attack = 0
var shovel_attack = false

# ------------------------- Calling Device ------------------------
var can_calling = true

var dead = false

var time_spent_knockback = 0

# snow ball drop
const snow_ball_drop = preload("res://effects/snow_ball_drop/snow_ball_drop.tscn")

# sniper smoke
const muzzle_smoke = preload("res://effects/muzzle_smoke/muzzle_smoke.tscn")

# pistol smoke
const pistol_muzzle_smoke = preload("res://effects/pistol_muzzle_smoke/pistol_muzzle_smoke.tscn")

# breath eff
const breath_eff = preload("res://effects/breath/breath.tscn")



# ------------- player main state ------------------------
enum {
	IDLE,
	MOVE,
	SIT,
}
# --------------------------- player sub state -------------------------------------------
enum {
	RELOADING,
	IS_CALLING,
	KNOCK_BACK,
	NULL,
}

# --------------------------- equipment state ----------------------------------------
enum {
	SNIPER, # สไน
	PISTOL, # ปืนพก
	KNIFE, # มีด
	BINOCULARS, # กล้องส่องทางไกล
	CALLING, # อุปกรณ์เรียก
	SHOVEL # พลั่ว
}


# --------------------------- initial state -------------------------------------------
var state = MOVE
var sub_state = NULL

var equ_state = KNIFE
var prev_equ_state = equ_state

# ----------------- for testing -----------------
onready var Check_zone = preload("res://scripts/check_zone/check_zone.gd").new()

# --------------------------- equment declare ------------------------------------------
onready var equipment_sniper = $equipment/sniper
onready var equipment_pistol = $equipment/pistol
onready var equipment_knife = $equipment/knife
onready var equipment_binoculars = $equipment/binoculars
onready var equipment_calling = $equipment/calling
onready var equipment_shovel = $equipment/shovel
onready var mouse_look_at = $equipment/mouse_global_position

onready var sniper_raycast = $equipment/sniper/RayCast2D
onready var pistol_raycast = $equipment/pistol/RayCast2D

#--------------------- equipment state --------------------- 
var is_zoom = false
var zoom_type = null
var zoomfactor = 1.0
var zoomspeed = 10.0
var scope_active = false
#------------------- end equipment state -------------------

#### player movement #####
#const MOVE_SPEED = 2000 # change from 300
const MOVE_SPEED = 300

export (float) var max_health = 100
onready var health = max_health setget _set_health

onready var anim_player = $AnimationPlayer
onready var sword_hitbox = $hitbox/sword_hitbox

var zone

var player_in_props = false

var ui_is_open = false

""" ======================================================================================="""
""" =====================================  code working ==================================="""
""" ======================================================================================="""

# --------------------------- godot function -------------------------------------------
func _ready():
	game.player = self
	
	self.global_position = Vector2(gamestate.state.current_pos[0],gamestate.state.current_pos[1])

	set_zone()
	
	# เปลี่ยนอาวุธเป็นปัจจุบัน
	change_current_rifle()
	change_current_pistol()
	
	toggle_visible_equ()
	
	$head_debug.text = str(health)
	
	add_to_group("update_menu_is_open")
	
	var _Con1 = $camping_check.connect("area_entered", self, "_on_camping_check_area_extered")
	
	#########################################################################
	yield(get_tree(), "idle_frame")
	get_tree().call_group("need_player_ref", "set_player", self)
	#########################################################################
	
func _input(_event):
	if sub_state != IS_CALLING and !ui_is_open and !reloading and !change_the_mag and !knife_attack:
		if Input.is_action_just_pressed("1") and equ_state != SNIPER:
			equ_state = SNIPER
			toggle_visible_equ()
			prev_equ_state = equ_state
			update_equ_stats()
		elif Input.is_action_just_pressed("2") and equ_state != PISTOL:
			equ_state = PISTOL
			toggle_visible_equ()
			prev_equ_state = equ_state
			update_equ_stats()
		elif Input.is_action_just_pressed("3") and equ_state != KNIFE:
			equ_state = KNIFE
			toggle_visible_equ()
			prev_equ_state = equ_state
			update_equ_stats()
		elif Input.is_action_just_pressed("4") and equ_state != BINOCULARS:
			equ_state = BINOCULARS
			toggle_visible_equ()
			prev_equ_state = equ_state
			update_equ_stats()
		elif Input.is_action_just_pressed("5") and equ_state != CALLING:
			equ_state = CALLING
			toggle_visible_equ()
			prev_equ_state = equ_state
			update_equ_stats()
		elif Input.is_action_just_pressed("6") and equ_state != SHOVEL:
			equ_state = SHOVEL
			toggle_visible_equ()
			prev_equ_state = equ_state
			update_equ_stats()
			
func _physics_process(delta):
	#$scope/ColorRect
	_head_debug()
	set_zone()
	match state:
		MOVE:
			#$eye_detection/CollisionShape2D.shape.radius = 500
			#$eye_detection/CollisionShape2D.shape.height = 1200
			$eye_detection/CollisionShape2D.shape.radius = 650
			$eye_detection/CollisionShape2D.shape.height = 1600
			match sub_state:
				RELOADING:
					equ_control_state(delta)
				IS_CALLING:
					if dead:
						pass
				KNOCK_BACK:
					knockback_sub_state(delta)
				NULL:
					move_state(delta)
					equ_control_state(delta)
		IDLE:
			$eye_detection/CollisionShape2D.shape.radius = 250
			$eye_detection/CollisionShape2D.shape.height = 600
			match sub_state:
				RELOADING:
					equ_control_state(delta)
				IS_CALLING:
					if dead:
						pass
				KNOCK_BACK:
					knockback_sub_state(delta)
				NULL:
					equ_control_state(delta)
					idle_state()
		SIT:
			$eye_detection/CollisionShape2D.shape.radius = 50
			$eye_detection/CollisionShape2D.shape.height = 150
			match sub_state:
				RELOADING:
					equ_control_state(delta)
				IS_CALLING:
					if dead:
						pass
				KNOCK_BACK:
					knockback_sub_state(delta)
				NULL:
					equ_control_state(delta)
					sit_state()
		_:
			print('not match state')

var i = 0
func _process(delta):
	i += delta
	if i > 1.5:
		breath()
		i = 0
		
func breath():
	var breath_obj = breath_eff.instance()
	breath_obj.global_position = $graphics/breath_position.global_position
	#breath_obj.global_rotation = global_rotation
	get_tree().get_root().add_child(breath_obj)
	breath_obj.emitting = true

var left_step = true
func step():
	left_step = !left_step
	var f = footstep.instance()
	f.add_to_group("delete_on_restart")
	get_tree().get_root().add_child(f)
	get_tree().get_root().move_child(f, 0)
	var step_spot = $RStep.global_position
	if left_step:
		step_spot = $LStep.global_position
	f.global_position = step_spot
	var steps = [step1, step2, step3]
	var cur_step = randi() % 3
	$step_player.stream = steps[cur_step]
	$step_player.play()

func equ_control_state(delta):
	if dead:
		return
	match equ_state:
		SNIPER:
			sniper_control(delta)
			
		PISTOL:
			pistol_control(delta)
			
		KNIFE:
			knife_cotrol(delta)
			
		BINOCULARS:
			binoculars_control(delta)
			
		CALLING:
			calling_control(delta)
			
		SHOVEL:
			shovel_control(delta)

func move_state(delta):
	
	if dead:
		return

	var move_vec = Vector2()
	if Input.is_action_pressed("move_down"):
		move_vec.y += 1
	if Input.is_action_pressed("move_up"):
		move_vec.y -= 1
	if Input.is_action_pressed("move_left"):
		move_vec.x -= 1
	if Input.is_action_pressed("move_right"):
		move_vec.x += 1
	move_vec = move_vec.normalized()

	move_and_slide(move_vec * MOVE_SPEED, Vector2())

	if move_vec != Vector2.ZERO:
		is_move = true
		cur_step_dist += MOVE_SPEED * delta
		if cur_step_dist > STEP_RATE:
			cur_step_dist -= STEP_RATE
			step()
	
	if move_vec == Vector2.ZERO:
		is_move = false
		update_state(IDLE)
	
	"""
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		#------------------------
		sword_hitbox.player_position = self.global_position
		#------------------------
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			
	velocity = move_and_slide(velocity)
	
	if velocity == Vector2.ZERO:
		update_state(IDLE)
	"""
	
	if Input.is_action_just_pressed("ctrl"):
		update_state(SIT)
	
	
			
	# เวลาส่องกล้องห้ามเดินเข้าใจไหม ถ้าเดินกล้องจะปิด
#	if $Camera2D.zoom.x != 1 and $Camera2D.zoom.y != 1 and velocity != Vector2(0,0):
#		zoom_type = null
#		zoomfactor = 1.0
#		is_zoom = false
#		$Camera2D.zoom.x = 1
#		$Camera2D.zoom.y = 1
	
func set_zone():
	Check_zone.get_zone(self.global_position)
	zone = Check_zone.zone
	
func _head_debug():
	set_zone()
	$head_debug.text = str(self.global_position)
	#$head_debug.text = str(zone)

#func attack_state(delta):
#	if !facing_right:
#		play_anim("sword_attack_right")
#	else:
#		play_anim("sword_attack_left")	
func idle_state():
	if Input.is_action_just_pressed("move_right") \
		or Input.is_action_just_pressed("move_left") \
		or Input.is_action_just_pressed("move_up") \
		or Input.is_action_just_pressed("move_down") \
		and state == IDLE:
			update_state(MOVE)
			return
	if Input.is_action_just_pressed("ctrl"):
		update_state(SIT)
			
func sit_state():
	if Input.is_action_just_pressed("ctrl") and state == SIT:
		update_state(IDLE)
	
	
func damage(amount):
	#_set_health(health - amount)
	self.health = (health - amount)
	#$head_debug.text = str(health)

func kill():
	#queue_free()
	pass

func knockback_sub_state(delta):
	velocity = velocity.move_toward(Vector2.ZERO, 2000 * delta)
	velocity = move_and_slide(velocity)
	time_spent_knockback += delta
	if time_spent_knockback >= 0.5:
		update_sub_state(NULL)
		update_state(MOVE)
		time_spent_knockback = 0
# --------------------------- ปิดอาวุธ แสดงอาวุธ --------------------------------------
func toggle_visible_equ():
	
	# --- visible false ---
	match prev_equ_state:
		SNIPER:
			if $Camera2D.zoom.x != 1 and $Camera2D.zoom.y != 1:
				zoom_type = null
				zoomfactor = 1.0
				is_zoom = false
				$Camera2D.zoom.x = 1
				$Camera2D.zoom.y = 1
			equipment_sniper.visible = false
			
		PISTOL:
			equipment_pistol.visible = false
			
		KNIFE:
			equipment_knife.visible = false
			$hitbox.visible = false
			
		BINOCULARS:
			if $Camera2D.zoom.x != 1 and $Camera2D.zoom.y != 1:
				zoom_type = null
				zoomfactor = 1.0
				is_zoom = false
				$Camera2D.zoom.x = 1
				$Camera2D.zoom.y = 1
			equipment_binoculars.visible = false
			
		CALLING:
			$calling_area/CollisionShape2D.disabled = true
			equipment_calling.visible = false
			
		SHOVEL:
			equipment_shovel.visible = false

	# --- visible true ---
	match equ_state:
		SNIPER:
			equipment_sniper.visible = true
			
		PISTOL:
			equipment_pistol.visible = true
			
		KNIFE:
			equipment_knife.visible = true
			$hitbox.visible = true
			
		BINOCULARS:
			equipment_binoculars.visible = true

		CALLING:
			equipment_calling.visible = true

		SHOVEL:
			equipment_shovel.visible = true
			
			
func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_update", health)
		if health <= 0:
			kill()
			emit_signal("killed")


func death():
	# death
	dead = true
	
	get_node("CollisionShape2D").set_deferred("disabled", true)
	get_node("hurtbox/CollisionPolygon2D").set_deferred("disabled", true)
	
	get_node("calling_area/CollisionShape2D").set_deferred("disabled", true)
	get_node("gun_shoot_sound_area/CollisionShape2D").set_deferred("disabled", true)
	get_node("eye_detection/CollisionShape2D").set_deferred("disabled", true)
	get_node("player_check_props/CollisionShape2D").set_deferred("disabled", true)
	
	set_process_input(false)
	set_physics_process(false)
	
	yield(get_tree().create_timer(3),"timeout")
	reborn()
	
func reborn():
	global_position = Vector2(0, 0)
	
	gamestate.state.health = 100
	gamestate.state.food = 100
	gamestate.state.water = 100
	gamestate.state.day = 1
	game.hp_food_water_bar.update_bar()
	game.hp_food_water_bar.update_hud_day()
	
	get_tree().call_group("player_is_dead", "set_position_when_player_dead", self)
	
	if $Camera2D.zoom.x != 1 and $Camera2D.zoom.y != 1:
		zoom_type = null
		zoomfactor = 1.0
		is_zoom = false
		$Camera2D.zoom.x = 1
		$Camera2D.zoom.y = 1

	get_node("CollisionShape2D").set_deferred("disabled", false)
	get_node("hurtbox/CollisionPolygon2D").set_deferred("disabled", false)
	
	get_node("calling_area/CollisionShape2D").set_deferred("disabled", false)
	get_node("gun_shoot_sound_area/CollisionShape2D").set_deferred("disabled", false)
	get_node("eye_detection/CollisionShape2D").set_deferred("disabled", false)
	get_node("player_check_props/CollisionShape2D").set_deferred("disabled", false)
	
	set_process_input(true)
	set_physics_process(true)
	
	state = MOVE
	sub_state = NULL
	
	game.hp_food_water_bar.death = false
	
	dead = false
	
	
func change_current_rifle() -> void:
	var cur_rifle:String = str(gamestate.state.current_equipment.rifle)
	var img_path = str(JsonGameMetaData.equipment.rifle[cur_rifle].texture)
	get_node("equipment/sniper/Sprite").texture = load(img_path)

func change_current_pistol() -> void:
	var cur_pistol:String = str(gamestate.state.current_equipment.pistol)
	var img_path = str(JsonGameMetaData.equipment.pistol[cur_pistol].texture)
	get_node("equipment/pistol/Sprite").texture = load(img_path)
	

func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)

func flip():
	$graphics.scale.x *= -1
	facing_right = !facing_right
	
func _load_gamestate():
	print('load game state')

#-------------------------------------------------------------------------------------------
#----------------------- equipment control -------------------------------------------------
func sniper_control(delta):
	
	if !reloading and !change_the_mag and !ui_is_open:
		equipment_sniper.look_at(get_global_mouse_position())
	
	if reloading:
		time_spent_reloading += delta
		if time_spent_reloading >= 0.5: 
			if !$sniper_reloading.playing:
				$sniper_reloading.play()
		if time_spent_reloading >= 1.2: # bullet sound
			if !$shells_falls.playing:
				$shells_falls.play()
		if time_spent_reloading >= RELOAD_TIME:
			reloading = false
			time_spent_reloading = 0
			update_sub_state(NULL)

			
	if change_the_mag:
		time_spent_sniper_chane_the_mag += delta
		if time_spent_sniper_chane_the_mag >= 1.0 and !$change_the_mag.playing:
			$change_the_mag.play()
		if time_spent_sniper_chane_the_mag >= 1.5 and !$sniper_reloading.playing:
			$sniper_reloading.play()
		if time_spent_sniper_chane_the_mag >= 3.0:
			change_the_mag = false
			time_spent_sniper_chane_the_mag = 0
			update_sub_state(NULL)
			
	if !reloading and !change_the_mag:
		equipment_sniper.scale.x = 1
		var r = equipment_sniper.global_rotation_degrees
		if (r > 90 or r < -90) and !facing_right:
			$graphics.scale.x *= -1
			facing_right = !facing_right
		if (r < 90 and r > -90) and facing_right:
			$graphics.scale.x *= -1
			facing_right = !facing_right
			
		if facing_right:
			equipment_sniper.scale.y = -1
		else:
			equipment_sniper.scale.y = 1
			
	if Input.is_action_just_pressed("left_click") and !reloading and !change_the_mag and !ui_is_open and !check.mouse_on_gui:
		if gamestate.state.sniper_ammo_current <= 0:
			if gamestate.state.sniper_mag <= 0:
				$gun_empty.play()
				return
			sniper_change_the_mag()
			update_sub_state(RELOADING)
			if state == MOVE:
				update_state(IDLE)
			return
			
		if !$sniper_sound.playing:
			$sniper_sound.play()
			var smoke = muzzle_smoke.instance()
			smoke.global_position = $equipment/sniper/fire_point.global_position
			smoke.global_rotation = sniper_raycast.global_rotation
			get_tree().get_root().add_child(smoke)
			smoke.emitting = true
			###
			zoom_type = "max_zoom_in"
			zoomfactor = 1.0
			is_zoom = false
			$Camera2D.zoom.x = 1
			$Camera2D.zoom.y = 1
			hide_scope()
			###
			$equipment/sniper/muzzle_flash.enabled = true
			sniper_shoot()
			update_sub_state(RELOADING)
			if state == MOVE:
				update_state(IDLE)
			
	if reloading:
		time_spent_muzzle_flash += delta
		if time_spent_reloading >= 0.2:
			$equipment/sniper/muzzle_flash.enabled = false
			time_spent_muzzle_flash = 0
			
	if Input.is_action_just_pressed("right_click") and !reloading and is_zoom == false and !change_the_mag and !ui_is_open and !check.mouse_on_gui:
		if zoom_type == "zoomout" or zoom_type == "max_zoom_out":
			zoom_type = "zoomin"
			is_zoom = true
		else:
			zoom_type = "zoomout"
			is_zoom = true
			show_scope()
	if zoom_type == "zoomout":
		zoomfactor += 0.01
		$Camera2D.zoom.x = lerp($Camera2D.zoom.x ,$Camera2D.zoom.x * zoomfactor, zoomspeed * delta)
		$Camera2D.zoom.y = lerp($Camera2D.zoom.y ,$Camera2D.zoom.y * zoomfactor, zoomspeed * delta)
		if zoomfactor > 1.3:
			zoom_type = "max_zoom_out"
			zoomfactor = 1.0
			is_zoom = false
	elif zoom_type == "zoomin":
		zoomfactor -= 0.01
		$Camera2D.zoom.x = lerp($Camera2D.zoom.x ,$Camera2D.zoom.x * zoomfactor, zoomspeed * delta)
		$Camera2D.zoom.y = lerp($Camera2D.zoom.y ,$Camera2D.zoom.y * zoomfactor, zoomspeed * delta)
		if zoomfactor < 0.7:
			zoom_type = "max_zoom_in"
			zoomfactor = 1.0
			is_zoom = false
			$Camera2D.zoom.x = 1
			$Camera2D.zoom.y = 1
			hide_scope()
	if scope_active:
		scope_control()
	if reloading:
		equipment_sniper.rotation = 0
		if !facing_right:
			equipment_sniper.scale.x = 1
		else:
			equipment_sniper.scale.x = -1
			#add new
			equipment_sniper.scale.y = 1
			
	if change_the_mag:
		equipment_sniper.rotation = 0
		if !facing_right:
			equipment_sniper.scale.x = 1
		else:
			equipment_sniper.scale.x = -1
			equipment_sniper.scale.y = 1
func show_scope():
	scope_active = true
	
	$scope/optical.show()
	$scope/scope_background.show()
func hide_scope():
	scope_active = false
	
	$scope/optical.hide()
	$scope/scope_background.hide()
func scope_control():

	$scope/optical.global_position.x = get_global_mouse_position().x
	$scope/optical.global_position.y = get_global_mouse_position().y
	
func sniper_shoot():
	
	if gamestate.state.sniper_ammo_current <= 0:
		update_equ_stats()
		return
	reloading = true
	
	gamestate.state.sniper_ammo_current -= 1
	update_equ_stats()
	if sniper_raycast.is_colliding():
		var coll = sniper_raycast.get_collider()
		
		if coll.name == "hurtbox":
			if coll.get_parent().has_method("take_damage"):
				coll.get_parent().take_damage(100)
				
	$gun_shoot_sound_area/CollisionShape2D.set_deferred("disabled", false)
	yield(get_tree().create_timer(0.1),"timeout")
	$gun_shoot_sound_area/CollisionShape2D.set_deferred("disabled", true)
	
func sniper_change_the_mag():
	change_the_mag = true
	if $Camera2D.zoom.x != 1 and $Camera2D.zoom.y != 1:
		zoom_type = null
		zoomfactor = 1.0
		is_zoom = false
		$Camera2D.zoom.x = 1
		$Camera2D.zoom.y = 1
	if gamestate.state.sniper_mag <= 5:
		gamestate.state.sniper_ammo_current = gamestate.state.sniper_mag
		gamestate.state.sniper_mag = 0
		update_equ_stats()
		return
	gamestate.state.sniper_ammo_current = 5
	gamestate.state.sniper_mag -= 5
	update_equ_stats()
	
		
func pistol_control(delta):
	if !reloading and !pistol_is_shoot and !change_the_mag and !ui_is_open: 
		equipment_pistol.look_at(get_global_mouse_position())
		
	if change_the_mag:
		time_spent_pistol_chane_the_mag += delta
		if time_spent_pistol_chane_the_mag >= 1.0 and !$change_the_mag.playing:
			$change_the_mag.play()
		if time_spent_pistol_chane_the_mag >= 1.5 and !$sniper_reloading.playing:
			$sniper_reloading.play()
		if time_spent_pistol_chane_the_mag >= 3.0:
			change_the_mag = false
			time_spent_pistol_chane_the_mag = 0
			
	if change_the_mag:
		equipment_pistol.rotation = 0
		if !facing_right:
			equipment_pistol.scale.x = 1
		else:
			equipment_pistol.scale.x = -1
			equipment_pistol.scale.y = 1
	
	if !reloading and !change_the_mag:
		equipment_pistol.scale.x = 1
		var r = equipment_pistol.global_rotation_degrees
		if (r > 90 or r < -90) and !facing_right:
			$graphics.scale.x *= -1
			facing_right = !facing_right
		if (r < 90 and r > -90) and facing_right:
			$graphics.scale.x *= -1
			facing_right = !facing_right
			
		if facing_right:
			equipment_pistol.scale.y = -1
		else:
			equipment_pistol.scale.y = 1
	
	if pistol_is_shoot:
		time_spent_pistol_muzzle_flash += delta
		if time_spent_pistol_muzzle_flash >= 0.1:
			$equipment/pistol/pistol_muzzle_flash.enabled = false
			time_spent_pistol_muzzle_flash = 0
			pistol_is_shoot = false
			
	if Input.is_action_just_pressed("left_click") and !change_the_mag and !ui_is_open and !check.mouse_on_gui: 
		if gamestate.state.pistol_ammo_current <= 0:
			if gamestate.state.pistol_mag <= 0:
				$gun_empty.play()
				return
			pistol_change_the_mag()
			return
		$pistol_sound.play()
		$equipment/pistol/pistol_muzzle_flash.enabled = true
		var smoke = pistol_muzzle_smoke.instance()
		smoke.global_position = $equipment/pistol/fire_point.global_position
		smoke.global_rotation = pistol_raycast.global_rotation
		get_tree().get_root().add_child(smoke)
		smoke.emitting = true
		pistol_shoot()


func pistol_shoot():
	if gamestate.state.pistol_ammo_current <= 0:
		update_equ_stats()
		return
	#reloading = true
	
	pistol_is_shoot = true
	gamestate.state.pistol_ammo_current -= 1
	update_equ_stats()
	if pistol_raycast.is_colliding():
		var coll = pistol_raycast.get_collider()
		
		if coll.name == "hurtbox":
			if coll.get_parent().has_method("take_damage"):
				coll.get_parent().take_damage(20)
	
	$gun_shoot_sound_area/CollisionShape2D.set_deferred("disabled", false)
	yield(get_tree().create_timer(0.1),"timeout")
	$gun_shoot_sound_area/CollisionShape2D.set_deferred("disabled", true)
			
func pistol_change_the_mag():
	change_the_mag = true
	if gamestate.state.pistol_mag <= 12:
		gamestate.state.pistol_ammo_current = gamestate.state.pistol_mag
		gamestate.state.pistol_mag = 0
		update_equ_stats()
		return
	gamestate.state.pistol_ammo_current = 12
	gamestate.state.pistol_mag -= 12
	update_equ_stats()
	
func knife_cotrol(delta):
	equipment_knife.scale.x = 1
	if !knife_attack and !ui_is_open:
		mouse_look_at.look_at(get_global_mouse_position())
		
	if knife_attack:
		time_spent_knife_attack += delta
		if time_spent_knife_attack >= 0.4:
			knife_attack = false
			time_spent_knife_attack = 0
	
	var r = mouse_look_at.global_rotation_degrees
	if (r > 90 or r < -90) and !facing_right:
		$graphics.scale.x *= -1
		facing_right = !facing_right
	elif (r < 90 and r > -90) and facing_right:
		$graphics.scale.x *= -1
		facing_right = !facing_right
	
	if !facing_right:
		equipment_knife.scale.x = 1
		$hitbox.scale.x = 1
	elif facing_right:
		equipment_knife.scale.x = -1
		$hitbox.scale.x = -1
		
	if Input.is_action_just_pressed("left_click") and !knife_attack and !ui_is_open and !check.mouse_on_gui:
		#state = ATTACK
		$knife_woosh.play()
		if !facing_right:
			play_anim("sword_attack_right")
		else:
			play_anim("sword_attack_left")
		knife_attack = true
		
func binoculars_control(delta):
	mouse_look_at.look_at(get_global_mouse_position())
	
	var r = mouse_look_at.global_rotation_degrees
	if (r > 90 or r < -90) and !facing_right:
		$graphics.scale.x *= -1
		facing_right = !facing_right
	elif (r < 90 and r > -90) and facing_right:
		$graphics.scale.x *= -1
		facing_right = !facing_right
	
	if !facing_right:
		equipment_binoculars.scale.x = 1
	elif facing_right:
		equipment_binoculars.scale.x = -1
		
	if Input.is_action_just_pressed("left_click") and is_zoom == false and equ_state == BINOCULARS and !ui_is_open and !check.mouse_on_gui:
		if zoom_type == "zoomout" or zoom_type == "max_zoom_out":
			zoom_type = "zoomin"
			is_zoom = true
		else:
			zoom_type = "zoomout"
			is_zoom = true
	if zoom_type == "zoomout":
		zoomfactor += 0.01
		$Camera2D.zoom.x = lerp($Camera2D.zoom.x ,$Camera2D.zoom.x * zoomfactor, zoomspeed * delta)
		$Camera2D.zoom.y = lerp($Camera2D.zoom.y ,$Camera2D.zoom.y * zoomfactor, zoomspeed * delta)
		if zoomfactor > 1.3:
			zoom_type = "max_zoom_out"
			zoomfactor = 1.0
			is_zoom = false
	elif zoom_type == "zoomin":
		zoomfactor -= 0.01
		$Camera2D.zoom.x = lerp($Camera2D.zoom.x ,$Camera2D.zoom.x * zoomfactor, zoomspeed * delta)
		$Camera2D.zoom.y = lerp($Camera2D.zoom.y ,$Camera2D.zoom.y * zoomfactor, zoomspeed * delta)
		if zoomfactor < 0.7:
			zoom_type = "max_zoom_in"
			zoomfactor = 1.0
			is_zoom = false
			$Camera2D.zoom.x = 1
			$Camera2D.zoom.y = 1
			
func calling_control(_delta):
	if !ui_is_open:
		mouse_look_at.look_at(get_global_mouse_position())
	
	var r = mouse_look_at.global_rotation_degrees
	if (r > 90 or r < -90) and !facing_right:
		$graphics.scale.x *= -1
		facing_right = !facing_right
	elif (r < 90 and r > -90) and facing_right:
		$graphics.scale.x *= -1
		facing_right = !facing_right
	
	if !facing_right:
		equipment_calling.scale.x = 1
	elif facing_right:
		equipment_calling.scale.x = -1
		
	if Input.is_action_just_pressed("left_click") and !ui_is_open and !check.mouse_on_gui:
		
		if !player_in_props:
			if game.main != null:
				game.text_alert.add_data_to_play("อยู่ในพุ่มหญ้าหรือใต้ต้นไม้เท่านั้นถึงใช้งานได้ ! ! !")
		elif !can_calling:
			if game.main != null:
				game.text_alert.add_data_to_play("กำลังรอระยะเวลา Cooldown ! ! !")
		else:
			if !$calling_sound.playing:
				$calling_sound.play()
				play_anim("call")
				
				$calling_area/CollisionShape2D.disabled = false
				$call_emotion.show()
				
				update_sub_state(IS_CALLING)
				if state == MOVE:
					update_state(IDLE)
					
				can_calling = false
				if game.main != null:
					game.equ_hud.get_node("background/calling_device/calling_cooldown").start_cooldown()

func shovel_control(delta):
	equipment_shovel.scale.x = 1
	
	if !ui_is_open and !shovel_attack:
		mouse_look_at.look_at(get_global_mouse_position())
		
	if shovel_attack:
		time_spent_shovel_attack += delta
		if time_spent_shovel_attack >= 0.5:
			shovel_attack = false
			time_spent_shovel_attack = 0
	
	var r = mouse_look_at.global_rotation_degrees
	if (r > 90 or r < -90) and !facing_right:
		$graphics.scale.x *= -1
		facing_right = !facing_right
	elif (r < 90 and r > -90) and facing_right:
		$graphics.scale.x *= -1
		facing_right = !facing_right
	
	if !facing_right:
		equipment_shovel.scale.x = 1
		get_node("snow_drop").scale.x = 1
	elif facing_right:
		equipment_shovel.scale.x = -1
		get_node("snow_drop").scale.x = -1
	
	if Input.is_action_just_pressed("left_click") and !shovel_attack and !ui_is_open and !check.mouse_on_gui:
		#state = ATTACK
		$knife_woosh.play()
		if !facing_right:
			play_anim("shovel_attack_left")
		else:
			play_anim("shovel_attack_right")
			
		var snow_ball_drop_obj = snow_ball_drop.instance()
		snow_ball_drop_obj.global_position = get_node("snow_drop/snow_drop_position").global_position
		get_tree().get_root().add_child(snow_ball_drop_obj)
		snow_ball_drop_obj.emitting = true
		
		shovel_attack = true
		
		if game.inventory != null:
			var affectedSlot = DataParser.inventory_addItem(105)
			if (affectedSlot >= 0):
				game.inventory.update_slot(affectedSlot)
				
				game.reward_alert.add_reward_to_play(105)
	
	
#------------------- end equipment control ------------------------------------------------
#------------------------------------------------------------------------------------------
"""----------------------------------------------------------------------------------------
 						Call Group
#------------------------------------------------------------------------------------------"""

func update_equ_stats():
	get_tree().call_group("update_equ_stats", "update_equ_stats", self)
	
func update_menu_is_open(s):
	ui_is_open = s
	if sub_state == KNOCK_BACK:
		return
	velocity = Vector2.ZERO
		
func update_state(s):
	state = s
	if sub_state == KNOCK_BACK:
		return
	velocity = Vector2.ZERO
	
func update_sub_state(s):
	sub_state = s
	if s == KNOCK_BACK:
		return
	velocity = Vector2.ZERO
	
"""----------------------------------------------------------------------------------------
 						Signal
#------------------------------------------------------------------------------------------"""

func _on_camping_check_area_extered(_area):
	print('has')

func _on_Area2D_area_entered(area):
	if area.name == "trap_area":
		damage(20)
	if area.name == "tooth_hitbox":
		var direction = (area.wolf_position - global_position).normalized()
		velocity = -direction * 1000
		update_sub_state(KNOCK_BACK)
		

		if game.main != null:
			
			if gamestate.state.health <= 0: 
				death()
				return
			
			gamestate.state.health -= 10
			if gamestate.state.health < 0:
				gamestate.state.health = 0
			game.hp_food_water_bar.update_bar()
			
			
			if gamestate.state.health <= 0:
				death()
			
		# --- take damage


func _on_calling_finished():
	$calling_area/CollisionShape2D.disabled = true
	$call_emotion.hide()
	anim_player.stop()
	update_sub_state(NULL)



func _on_player_check_props_body_entered(_body):
	player_in_props = true


func _on_player_check_props_body_exited(_body):
	player_in_props = false
	
	
func _on_player_check_props_area_entered(_area):
	player_in_props = true


func _on_player_check_props_area_exited(_area):
	player_in_props = false
