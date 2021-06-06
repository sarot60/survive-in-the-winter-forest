extends CanvasLayer

const MENU_SCN = "res://screens/start_menu/start_menu.tscn"

func _ready():
	var _tmpStr = ""
	_tmpStr = _tmpStr + "การควบคุมตัวละคร \n"
	_tmpStr = _tmpStr + "\t\t\t เดินขึ้น W \n"
	_tmpStr = _tmpStr + "\t\t\t เดินลง S \n"
	_tmpStr = _tmpStr + "\t\t\t เดินซ้าย A \n"
	_tmpStr = _tmpStr + "\t\t\t เดินขวา D \n\n"
	
	_tmpStr = _tmpStr + "การใช้อุปกรณ์ \n"
	_tmpStr = _tmpStr + "\t\t\t อุปกรณ์เลข 1 (สไนเปอร์) : คลิกซ้ายยิง คลิกขวาเล็งกล้อง \n"
	_tmpStr = _tmpStr + "\t\t\t อุปกรณ์เลข 2 (ปืนพก) : คลิกซ้ายยิง \n"
	_tmpStr = _tmpStr + "\t\t\t อุปกรณ์เลข 3 (มีด) : คลิกซ้ายสำหรับฟัน \n"
	_tmpStr = _tmpStr + "\t\t\t อุปกรณ์เลข 4 (กล้องส่องทางไกล) : คลิกซ้ายสำหรับส่องกล้อง \n"
	_tmpStr = _tmpStr + "\t\t\t อุปกรณ์เลข 5 (อุปกรณ์เลียนแบบเสียงสัตว์) : คลิกซ้ายสำหรับใช้งาน \n"
	_tmpStr = _tmpStr + "\t\t\t อุปกรณ์เลข 6 (พลั่ว) : คลิกซ้ายเพื่อทำการขุด \n\n"
	
	_tmpStr = _tmpStr + "การเปิดเมนูโดยกดปุ่ม B \n"
	_tmpStr = _tmpStr + "\t\t\t เมนู 1 : กระเป๋าผู้เล่น \n"
	_tmpStr = _tmpStr + "\t\t\t เมนู 2 : ภารกิจ หรือ เควส \n"
	_tmpStr = _tmpStr + "\t\t\t เมนู 3 : ทักษะผู้เล่น \n"
	_tmpStr = _tmpStr + "\t\t\t เมนู 4 : จัดการอุปกรณ์ \n"
	_tmpStr = _tmpStr + "\t\t\t เมนู 5 : รายละเอียดตัวละคร \n\n"
	
	$bg/RichTextLabel.text = _tmpStr

func _on_back_button_pressed():
	if game.main == null: return
	game.main.load_screen(MENU_SCN)
