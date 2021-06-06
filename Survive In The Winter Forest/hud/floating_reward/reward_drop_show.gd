extends Control


var item_reward_stack:Array = []

onready var anim_player = $AnimationPlayer

func _ready():
	game.reward_alert = self
	hide()

func add_reward_to_play(item_key:int) -> void:
	item_reward_stack.append(item_key)
	
	if item_reward_stack.size() > 1:
		if item_reward_stack[item_reward_stack.size() - 1] == item_key:
			item_reward_stack.pop_back()
			
	if !anim_player.is_playing():
		set_texture_to_play_anim()

func set_texture_to_play_anim():
	show()
	var _item_texture = str(JsonGameMetaData.item_meta_data[str(item_reward_stack[0])].icon)
	$icon.texture = load(_item_texture)
	item_reward_stack.pop_front()
	play_anim("play")

func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)

func _on_AnimationPlayer_animation_finished(_anim_name):
	if item_reward_stack.size() > 0:
		set_texture_to_play_anim()
	else:
		hide()
