extends Node

var parent_obj:Object = null
var parent_obj_type:String = ""
var item_drop_list:Array = []
var quest_drop_list:Array = []

func drop_set_data(obj:Object, obj_type:String, item_keys:Array, item_quest_key:Array) -> void:
	if obj == null: return
	if obj_type == null: return
	if item_keys.size() < 1: return
	
	self.parent_obj = obj
	self.parent_obj_type = obj_type
	self.item_drop_list = item_keys
	self.quest_drop_list = item_quest_key
	
	match obj_type:
		"berries":
			props_type_berries()
		"grass":
			props_type_grass()
		"branch":
			props_type_branch()
		_:
			return
	
func props_type_berries() -> void:
	if parent_obj == null: return
	if parent_obj_type == "": return
	if item_drop_list.size() < 1: return
	
func props_type_grass() -> void:
	if parent_obj == null: return
	if parent_obj_type == "": return
	if item_drop_list.size() < 1: return
	
func props_type_branch() -> void:
	if parent_obj == null: return
	if parent_obj_type == "": return
	if item_drop_list.size() < 1: return
