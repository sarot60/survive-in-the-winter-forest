extends Node

var item_meta_data: Dictionary = {
	# ------------------------------ Emyty Slot --------------------------------
	
	"0": {
		"name": "",
		"thai_name": "",
		"icon": "res://assets/items/empty_slot.png",
		"type": "misc",
		"weight": 0.0,
		"stackable": false,
		"stack_limit": 1,
		"description": "",
		"sell_price": 0
	},
	
	# ------------------------------ Material ----------------------------------
	"101": {
		"name": "Stick",
		"thai_name": "แท่งไม้",
		"icon": "res://assets/items/material/stick.png",
		"type": "material",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "แท่งไม้ ใช้สำหรับการก่อไฟและงานอเนกประสงค์ต่างๆ",
		"sell_price": 0
	},
	"102": {
		"name": "Rope",
		"thai_name": "เชือก",
		"icon": "res://assets/items/material/rope.png",
		"type": "material",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "เชือก ใช้งานอเนกประสงค์ต่างๆ",
		"sell_price": 0
	},
	"103": {
		"name": "Blade of grass",
		"thai_name": "ใบหญ้า",
		"icon": "res://assets/items/material/blade_of_grass.png",
		"type": "material",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "ใบหญ้า ใช้สำหรับการก่อไฟ",
		"sell_price": 0
	},
	"104": {
		"name": "Empty Bottle",
		"thai_name": "ขวดเปล่า",
		"icon": "res://assets/items/material/empty_bottle.png",
		"type": "material",
		"weight": 0.0,
		"stackable": false,
		"stack_limit": 1,
		"description": "ขวดเปล่า ใช้สำหรับเก็บน้ำ",
		"sell_price": 0
	},
	"105": {
		"name": "Snowball",
		"thai_name": "ก้อนหิมะ",
		"icon": "res://assets/items/material/snowball.png",
		"type": "material",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "ก้อนหิมะ ใช้หรับหรับเป็นวัตถุดับในการต้มน้ำ",
		"sell_price": 0
	},
	
	# -------------------------------- Food ------------------------------------
	"501": {
		"name": "Water Bottle",
		"thai_name": "ขวดน้ำ",
		"icon": "res://assets/items/food/water_bottle.png",
		"type": "food",
		"weight": 0.0,
		"stackable": false,
		"stack_limit": 1,
		"description": "ขวดน้ำ ใช้สำหรับทานเพื่อเพิ่มน้ำ",
		"sell_price": 95,
		"benefits": {
			"health": null,
			"food": null,
			"water": 50
		}
	},
	"502": {
		"name": "Cranberries",
		"thai_name": "แครนเบอร์รี่",
		"icon": "res://assets/items/food/cranberries.png",
		"type": "food",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "แครนเบอร์รี่ ผลไม้ใช้สำหรับทานเพื่อเพิ่มอาหาร",
		"sell_price": 95,
		"benefits": {
			"health": null,
			"food": 50,
			"water": null
		}
	},
	"503": {
		"name": "Juniper Berries",
		"thai_name": "จูนิเปอร์เบอร์รี่",
		"icon": "res://assets/items/food/juniper_berries.png",
		"type": "food",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "จูนิเปอร์เบอร์รี่ ผลไม้ใช้สำหรับทานเพื่อเพิ่มอาหาร",
		"sell_price": 95,
		"benefits": {
			"health": null,
			"food": 50,
			"water": null
		}
	},
	"504": {
		"name": "Grilled Wolf Meat",
		"thai_name": "เนื้อหมาป่าย่าง",
		"icon": "res://assets/items/food/grilled_wolf_meat.png",
		"type": "food",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "เนื้อหมาป่าย่าง ใช้สำหรับทานเพื่อเพิ่มอาหาร",
		"sell_price": 0,
		"benefits": {
			"health": null,
			"food": 70,
			"water": null
		}
	},
	"505": {
		"name": "Roast Rabbit",
		"thai_name": "เนื้อกระต่ายย่าง",
		"icon": "res://assets/items/food/roast_rabbit.png",
		"type": "food",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "เนื้อกระต่ายย่าง ใช้สำหรับทานเพื่อเพิ่มอาหาร",
		"sell_price": 0,
		"benefits": {
			"health": null,
			"food": 70,
			"water": null
		}
	},
	"506": {
		"name": "Roast Venison",
		"thai_name": "เนื้อกวางย่าง",
		"icon": "res://assets/items/food/roast_venison.png",
		"type": "food",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "เนื้อกวางย่าง ใช้สำหรับทานเพื่อเพิ่มอาหาร",
		"sell_price": 0,
		"benefits": {
			"health": null,
			"food": 70,
			"water": null
		}
	},
	
	# -------------------------------- Meat ------------------------------------
	"201": {
		"name": "Wolf Meat",
		"thai_name": "เนื้อหมาป่าดิบ",
		"icon": "res://assets/items/meat/wolf_meat.png",
		"type": "meat",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "เนื้อหมาป่าดิบ เนื้อใช้สำหรับทำอาหาร",
		"sell_price": 0
	},
	"202": {
		"name": "Rabbit Meat",
		"thai_name": "เนื้อกระต่ายดิบ",
		"icon": "res://assets/items/meat/rabbit_meat.png",
		"type": "meat",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "เนื้อกระต่ายดิบ เนื้อใช้สำหรับทำอาหาร",
		"sell_price": 0
	},
	"203": {
		"name": "Venison",
		"thai_name": "เนื้อกวางดิบ",
		"icon": "res://assets/items/meat/venison.png",
		"type": "meat",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "เนื้อกวางดิบ เนื้อใช้สำหรับทำอาหาร",
		"sell_price": 0
	},
	
	# -------------------------------- Herb ------------------------------------
	# -------------------------------- Herb ------------------------------------
	# -------------------------------- Herb ------------------------------------
	
	"301": {
		"name": "Mint",
		"thai_name": "มินต์", # สะระแหน่
		"icon": "res://assets/items/herb/mint.png",
		"type": "herb",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "มินต์ หรือ สาระแหน่ เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefits": {
			"health": 50,
			"food": 20,
			"water": null
		},
		# https://yolo.in.th/articles/9-benefits-peppermint-oil/
		# https://medthai.com/%E0%B8%AA%E0%B8%B0%E0%B8%A3%E0%B8%B0%E0%B9%81%E0%B8%AB%E0%B8%99%E0%B9%88/
		"details": {
			"0": "บรรเทาอาการโรคกระเพาะ",
			"1": "รักษาโรคลำไส้แปรปรวน",
			"2": "ช่วยแก้พิษจากแมลงสัตว์กัดต่อย",
			"3": "ช่วยแก้อาการท้องอืด ท้องเฟ้อ",
			"4": "ช่วยแก้อาการจุกเสียดในท้องเด็ก"
		}
	},
	"302": {
		"name": "Rosemary",
		"thai_name": "โรสแมรี่",
		"icon": "res://assets/items/herb/rosemary.png",
		"type": "herb",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "โรสแมรี่่ เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefits": {
			"health": 50,
			"food": 20,
			"water": null
		},
		# https://www.liponf.co.th/blog/rosemary-benefits
		"details": {
			"0": "บรรเทาอาการปวดหัว ไมเกรน ปวดเมื่อย ปวดท้องประจำเดือน",
			"1": "ลดอาการไอ",
			"2": "ลดความเครียด",
			"3": "ช่วยเพิ่มภูมิคุ้มกัน ต้านการอักเสบ",
			"4": "ช่วยย่อยอาหาร แก้จุกเสียดแน่นท้อง แก้ท้องอืด แก้ท้องเฟ้อ ขับลมจากลำไส้"
		}
	},
	"303": {
		"name": "Parsley",
		"thai_name": "พาร์สลีย์",
		"icon": "res://assets/items/herb/parsley.png",
		"type": "herb",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "พาร์สลีย์ เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefits": {
			"health": 50,
			"food": 20,
			"water": null
		},
		# https://medthai.com/%E0%B8%9E%E0%B8%B2%E0%B8%A3%E0%B9%8C%E0%B8%AA%E0%B8%A5%E0%B8%B5%E0%B9%88%E0%B8%A2%E0%B9%8C/
		"details": {
			"0": "ช่วยแก้อาการคลื่นไส้อาเจียน",
			"1": "ช่วยขับเสมหะและละลายเสมหะ",
			"2": "ใช้เป็นยาขับปัสสาวะ",
			"3": "ใบมีสรรพคุณเป็นยาแก้อาการสะอึก",
			"4": "ช่วยลดระดับน้ำตาลในเลือด ลดความดันโลหิต"
		}
	},
	"304": {
		"name": "Thyme",
		"thai_name": "ไทม์",
		"icon": "res://assets/items/herb/thyme.png",
		"type": "herb",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "ไทม์ เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefits": {
			"health": 50,
			"food": 20,
			"water": null
		},
		# https://hellokhunmor.com/%E0%B8%A2%E0%B8%B2-%E0%B8%AA%E0%B8%A1%E0%B8%B8%E0%B8%99%E0%B9%84%E0%B8%9E%E0%B8%A3-%E0%B8%81-%E0%B8%AE/%E0%B8%AA%E0%B8%A1%E0%B8%B8%E0%B8%99%E0%B9%84%E0%B8%9E%E0%B8%A3-%E0%B8%81-%E0%B8%AE/%E0%B9%84%E0%B8%97%E0%B8%A1%E0%B9%8C-thyme/#gref
		"details": {
			"0": "ช่วยบรรเทาอาการท้องร่วง",
			"1": "ช่วยบรรเทาอาการท้องใส้ปั่นป่วน",
			"2": "ช่วยบรรเทาอาการปวดท้อง",
			"3": "ช่วยบรรเทาโรคกระเพาะอาหารอักเสบ",
			"4": "ช่วยรักษาโรคกระเพาะอาหารอักเสบ"
		}
	},
	"305": {
		"name": "Winter Savory",
		"thai_name": "วินเทอร์ ซาวอรี่",
		"icon": "res://assets/items/herb/winter_savory.png",
		"type": "herb",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "วินเทอร์ ซาวอรี่ เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefits": {
			"health": 50,
			"food": 20,
			"water": null
		},
		# https://hellokhunmor.com/%E0%B8%A2%E0%B8%B2-%E0%B8%AA%E0%B8%A1%E0%B8%B8%E0%B8%99%E0%B9%84%E0%B8%9E%E0%B8%A3-%E0%B8%81-%E0%B8%AE/%E0%B8%AA%E0%B8%A1%E0%B8%B8%E0%B8%99%E0%B9%84%E0%B8%9E%E0%B8%A3-%E0%B8%81-%E0%B8%AE/%E0%B8%A7%E0%B8%B4%E0%B8%99%E0%B9%80%E0%B8%97%E0%B8%AD%E0%B8%A3%E0%B9%8C-%E0%B8%8B%E0%B8%B2%E0%B9%82%E0%B8%A7%E0%B8%A3%E0%B8%B5%E0%B9%88-winte-savory/#gref
		"details": {
			"0": "ช่วยลดก๊าซในกระเพาะอาหาร",
			"1": "ช่วยรักษาอาการไอและเจ็บคอ",
			"2": "แก้อาการอาหารไม่ย่อย",
			"3": "ช่วยรักษาอาการท้องร่วง",
			"4": "ช่วยรักษาอาการคลื่นไส้"
		}
	},
	"306": {
		"name": "Basil",
		"thai_name": "แบสอิล", # โหระพา
		"icon": "res://assets/items/herb/basil.png",
		"type": "herb",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "แบสอิล เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefits": {
			"health": 50,
			"food": 20,
			"water": null
		},
		# https://medthai.com/%E0%B9%82%E0%B8%AB%E0%B8%A3%E0%B8%B0%E0%B8%9E%E0%B8%B2/
		"details": {
			"0": "ช่วยในการเจริญอาหาร",
			"1": "แก้อาการวิงเวียนศีรษะด้วยการนำใบมาต้มดื่ม",
			"2": "ช่วยรักษาโรคตาแดง ต้อตา มีขี้ตามาก",
			"3": "มีฤทธิ์ในการต่อต้านการอักเสบ",
			"4": "ช่วยแก้หวัดและช่วยในการขับเหงื่อ"
		}
	},
	"307": {
		"name": "Sage",
		"thai_name": "เสจ",
		"icon": "res://assets/items/herb/sage.png",
		"type": "herb",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "เสจ เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefits": {
			"health": 50,
			"food": 20,
			"water": null
		},
		# https://medthai.com/%E0%B9%80%E0%B8%AA%E0%B8%88/
		"details": {
			"0": "ช่วยรักษาอาการเบื่ออาหาร",
			"1": "แก้เจ็บคอ",
			"2": "รักษาแผลร้อนใน",
			"3": "ช่วยให้กล้ามเนื้อแข็งแรง",
			"4": "ช่วยเพิ่มสมาธิ ผ่อนคลายความวิตกกังวล"
		}
	},
	"308": {
		"name": "Chives",
		"thai_name": "ชิเวส",
		"icon": "res://assets/items/herb/chives.png",
		"type": "herb",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "ชิเวส หรือต้นหอมจีน เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefits": {
			"health": 50,
			"food": 20,
			"water": null
		},
		# https://beezab.com/tag/garlic-chives/
		# https://medthai.com/%E0%B8%81%E0%B8%B8%E0%B8%A2%E0%B8%8A%E0%B9%88%E0%B8%B2%E0%B8%A2/
		"details": {
			"0": "ช่วยบำรุงกระดูก",
			"1": "ช่วยลดระดับความดัน รักษาโรคความดันโลหิตสูง",
			"2": "ใช้เป็นยาแก้หวัด",
			"3": "ช่วยแก้ลมพิษ",
			"4": "ใบใช้ทาท้องเด็กช่วยแก้อาการท้องอืด"
		}
	},
	"309": {
		"name": "Oregano",
		"thai_name": "ออริกาโน",
		"icon": "res://assets/items/herb/oregano.png",
		"type": "herb",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "ออริกาโน เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefits": {
			"health": 50,
			"food": 20,
			"water": null
		},
		# https://hellokhunmor.com/%E0%B8%A2%E0%B8%B2-%E0%B8%AA%E0%B8%A1%E0%B8%B8%E0%B8%99%E0%B9%84%E0%B8%9E%E0%B8%A3-%E0%B8%81-%E0%B8%AE/%E0%B8%AA%E0%B8%A1%E0%B8%B8%E0%B8%99%E0%B9%84%E0%B8%9E%E0%B8%A3-%E0%B8%81-%E0%B8%AE/%E0%B8%AD%E0%B8%AD%E0%B8%A3%E0%B8%B4%E0%B8%81%E0%B8%B2%E0%B9%82%E0%B8%99-oregano/#gref
		"details": {
			"0": "ช่วยบรรเทาอาการปวดประจำเดือน",
			"1": "ช่วยบรรเทาอาการท้องอืด",
			"2": "ช่วยรักษาโรคปวดข้อ",
			"3": "ช่วยบรรเทาอาการท้องเฟ้อ",
			"4": "ช่วยบรรเทาอาการปวดหู"
		}
	},
	"310": {
		"name": "Catnip",
		"thai_name": "แคทนิป", # กัญชาแมว
		"icon": "res://assets/items/herb/catnip.png",
		"type": "herb",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "แคทนิป หรือ กัญชาแมว เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefits": {
			"health": 50,
			"food": 20,
			"water": null
		},
		# https://www.bloggang.com/mainblog.php?id=fasaiwonmai&month=27-07-2015&group=2&gblog=700
		"details": {
			"0": "ช่วยลดอาการจุกเสียด",
			"1": "บรรเทาอาการไข้",
			"2": "ช่วยลดอาการปวดฟัน",
			"3": "ช่วยลดอาการปวดหัว",
			"4": "มีฤทธิ์ในการไล่แมลงสาบ ไล่ยุง และแมลงวัน"
		}
	},
	"311": {
		"name": "Sorrel",
		"thai_name": "ซอร์เรล",
		"icon": "res://assets/items/herb/sorrel.png",
		"type": "herb",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "ซอร์เรล เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefits": {
			"health": 50,
			"food": 20,
			"water": null
		},
		# https://hellokhunmor.com/%E0%B8%A2%E0%B8%B2-%E0%B8%AA%E0%B8%A1%E0%B8%B8%E0%B8%99%E0%B9%84%E0%B8%9E%E0%B8%A3-%E0%B8%81-%E0%B8%AE/%E0%B8%AA%E0%B8%A1%E0%B8%B8%E0%B8%99%E0%B9%84%E0%B8%9E%E0%B8%A3-%E0%B8%81-%E0%B8%AE/%E0%B8%8B%E0%B8%AD%E0%B9%80%E0%B8%A3%E0%B8%A5-sorrel/#gref
		"details": {
			"0": "ช่วยลดอาการปวดของโพรงจมูกและทางเดินหายใจ",
			"1": "ช่วยลดอาการบวม อักเสบเฉียบพลัน ของโพรงจมูกและทางเดินหายใจ",
			"2": "เพิ่มการขับถ่ายปัสสาวะ",
			"3": "ช่วยรักษาเชื้อแบคทีเรีย",
			"4": "ช่วยรักษาอาการไซนัส"
		}
	},
	"312": {
		"name": "Caraway",
		"thai_name": "คาราเวย์",
		"icon": "res://assets/items/herb/caraway.png",
		"type": "herb",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "คาราเวย์ เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefits": {
			"health": 50,
			"food": 20,
			"water": null
		},
		# https://medthai.com/%E0%B9%80%E0%B8%97%E0%B8%B5%E0%B8%A2%E0%B8%99%E0%B8%95%E0%B8%B2%E0%B8%81%E0%B8%9A/
		# https://ccpe.pharmacycouncil.org/index.php?option=article_detail&subpage=article_detail&id=307
		"details": {
			"0": "ช่วยแก้อาการคลื่นไส้อาเจียน",
			"1": "ช่วยขับเสมหะ",
			"2": "เมล็ดมีสรรพคุณเป็นยาขับลม ช่วยขับลมในลำไส้เล็ก",
			"3": "ช่วยแก้อาการปวดหลัง แก้อาการเกร็ง",
			"4": "ช่วยแก้อาการปวดประจำเดือนของสตรี"
		}
	},
	"313": {
		"name": "Tarragon",
		"thai_name": "ทาร์รากอน",
		"icon": "res://assets/items/herb/tarragon.png",
		"type": "herb",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "ทาร์รากอน เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefits": {
			"health": 50,
			"food": 20,
			"water": null
		},
		# https://th.blabto.com/4868-the-use-of-tarragon-in-cooking-and-traditional-medic.html
		"details": {
			"0": "ช่วยจากหวัด",
			"1": "ลดความดัน สามารถใช้ในการรักษาความดันโลหิตสูง",
			"2": "บรรเทาความเครียดและความวิตกกังวล",
			"3": "เสริมสร้างกระดูก",
			"4": "ช่วยรักษาลิ่มเลือดอุดตันและเส้นเลือดขอด"
		}
	},
	"314": {
		"name": "Horseradish",
		"thai_name": "ฮอสแรดิช",
		"icon": "res://assets/items/herb/horseradish.png",
		"type": "herb",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "ฮอสแรดิช เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefits": {
			"health": 50,
			"food": 20,
			"water": null
		},
		# https://hellokhunmor.com/%E0%B8%A2%E0%B8%B2-%E0%B8%AA%E0%B8%A1%E0%B8%B8%E0%B8%99%E0%B9%84%E0%B8%9E%E0%B8%A3-%E0%B8%81-%E0%B8%AE/%E0%B8%AA%E0%B8%A1%E0%B8%B8%E0%B8%99%E0%B9%84%E0%B8%9E%E0%B8%A3-%E0%B8%81-%E0%B8%AE/%E0%B8%AE%E0%B8%AD%E0%B8%AA%E0%B9%81%E0%B8%A3%E0%B8%94%E0%B8%B4%E0%B8%8A-horseradish/#gref
		"details": {
			"0": "ทาลงบนผิวเพื่อรักษาอาการเจ็บข้อ",
			"1": "ทาลงบนผิวเพื่อรักษาอาการข้อบวม",
			"2": "ทาลงบนผิวเพื่อรักษาอาการเนื้อเยื่อบวม",
			"3": "ทาลงบนผิวเพื่อรักษาอาการปวดกล้ามเนื้อ",
			"4": "บรรเทาอาการปวดจากกระดูกทับเส้นประสาท"
		}
	},
	
	# -------------------------- Quest ---------------------------------------
	# -------------------------- Quest ---------------------------------------
	# -------------------------- Quest ---------------------------------------
	
	"901": {
		"name": "Stick",
		"thai_name": "แท่งไม้",
		"icon": "res://assets/items/material/stick.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "แท่งไม้ ใช้สำหรับการก่อไฟและงานอเนกประสงค์ต่างๆ",
		"sell_price": 0
	},
	"902": {
		"name": "Rope",
		"thai_name": "เชือก",
		"icon": "res://assets/items/material/rope.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "เชือก ใช้งานอเนกประสงค์ต่างๆ",
		"sell_price": 0
	},
	"903": {
		"name": "Blade of grass",
		"thai_name": "ใบหญ้า",
		"icon": "res://assets/items/material/blade_of_grass.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "ใบหญ้า ใช้สำหรับการก่อไฟ",
		"sell_price": 0
	},
	"904": {
		"name": "Empty Bottle",
		"thai_name": "ขวดเปล่า",
		"icon": "res://assets/items/material/empty_bottle.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": false,
		"stack_limit": 9999,
		"description": "ขวดเปล่า ใช้สำหรับเก็บน้ำ",
		"sell_price": 0
	},
	"905": {
		"name": "Snowball",
		"thai_name": "ก้อนหิมะ",
		"icon": "res://assets/items/material/snowball.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "ก้อนหิมะ ใช้หรับหรับเป็นวัตถุดับในการต้มน้ำ",
		"sell_price": 0
	},
	"906": {
		"name": "Water Bottle",
		"thai_name": "ขวดน้ำ",
		"icon": "res://assets/items/food/water_bottle.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": false,
		"stack_limit": 1,
		"description": "ขวดน้ำ ใช้สำหรับทานเพื่อเพิ่มน้ำ",
		"sell_price": 95,
		"benefits": {
			"health": null,
			"food": null,
			"water": null
		}
	},
	"907": {
		"name": "Cranberries",
		"thai_name": "แครนเบอร์รี่",
		"icon": "res://assets/items/food/cranberries.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "แครนเบอร์รี่ ผลไม้ใช้สำหรับทานเพื่อเพิ่มอาหาร",
		"sell_price": 95,
		"benefits": {
			"health": null,
			"food": null,
			"water": null
		}
	},
	"908": {
		"name": "Juniper Berries",
		"thai_name": "จูนิเปอร์เบอร์รี่",
		"icon": "res://assets/items/food/juniper_berries.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "จูนิเปอร์เบอร์รี่ ผลไม้ใช้สำหรับทานเพื่อเพิ่มอาหาร",
		"sell_price": 95,
		"benefits": {
			"health": null,
			"food": null,
			"water": null
		}
	},
	"909": {
		"name": "Grilled Wolf Meat",
		"thai_name": "เนื้อหมาป่าย่าง",
		"icon": "res://assets/items/food/grilled_wolf_meat.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "เนื้อหมาป่าย่าง ใช้สำหรับทานเพื่อเพิ่มอาหาร",
		"sell_price": 0,
		"benefits": {
			"health": null,
			"food": null,
			"water": null
		}
	},
	"910": {
		"name": "Roast Rabbit",
		"thai_name": "เนื้อกระต่ายย่าง",
		"icon": "res://assets/items/food/roast_rabbit.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "เนื้อกระต่ายย่าง ใช้สำหรับทานเพื่อเพิ่มอาหาร",
		"sell_price": 0,
		"benefits": {
			"health": null,
			"food": null,
			"water": null
		}
	},
	"911": {
		"name": "Roast Venison",
		"thai_name": "เนื้อกวางย่าง",
		"icon": "res://assets/items/food/roast_venison.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "เนื้อกวางย่าง ใช้สำหรับทานเพื่อเพิ่มอาหาร",
		"sell_price": 0,
		"benefits": {
			"health": null,
			"food": null,
			"water": null
		}
	},
	"999": {
		"name": "Boss Wolf Meat",
		"thai_name": "เนื้อบอสหมาป่าดิบ",
		"icon": "res://assets/items/meat/wolf_meat.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "เนื้อบอสหมาป่าดิบ เนื้อใช้สำหรับทำอาหาร",
		"sell_price": 0
	},
	"912": {
		"name": "Wolf Meat",
		"thai_name": "เนื้อหมาป่าดิบ",
		"icon": "res://assets/items/meat/wolf_meat.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "เนื้อหมาป่าดิบ เนื้อใช้สำหรับทำอาหาร",
		"sell_price": 0
	},
	"913": {
		"name": "Rabbit Meat",
		"thai_name": "เนื้อกระต่ายดิบ",
		"icon": "res://assets/items/meat/rabbit_meat.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "เนื้อกระต่ายดิบ เนื้อใช้สำหรับทำอาหาร",
		"sell_price": 0
	},
	"914": {
		"name": "Venison",
		"thai_name": "เนื้อกวางดิบ",
		"icon": "res://assets/items/meat/venison.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "เนื้อกวางดิบ เนื้อใช้สำหรับทำอาหาร",
		"sell_price": 0
	},	
	"915": {
		"name": "Mint",
		"thai_name": "มินต์",
		"icon": "res://assets/items/herb/mint.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "มินต์ หรือ สาระแหน่ เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefit": {
			"health": null,
			"food": null,
			"water": null
		},
		"details": {
			"0": "บรรเทาอาการโรคกระเพาะ",
			"1": "รักษาโรคลำไส้แปรปรวน",
			"2": "ช่วยแก้พิษจากแมลงสัตว์กัดต่อย",
			"3": "ช่วยแก้อาการท้องอืด ท้องเฟ้อ",
			"4": "ช่วยแก้อาการจุกเสียดในท้องเด็ก"
		}
	},
	"916": {
		"name": "Rosemary",
		"thai_name": "โรสแมรี่",
		"icon": "res://assets/items/herb/rosemary.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "โรสแมรี่่ เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefit": {
			"health": null,
			"food": null,
			"water": null
		},
		"details": {
			"0": "บรรเทาอาการปวดหัว ไมเกรน ปวดเมื่อย ปวดท้องประจำเดือน",
			"1": "ลดอาการไอ",
			"2": "ลดความเครียด",
			"3": "ช่วยเพิ่มภูมิคุ้มกัน ต้านการอักเสบ",
			"4": "ช่วยย่อยอาหาร แก้จุกเสียดแน่นท้อง แก้ท้องอืด แก้ท้องเฟ้อ ขับลมจากลำไส้"
		}
	},
	"917": {
		"name": "Parsley",
		"thai_name": "พาร์สลีย์",
		"icon": "res://assets/items/herb/parsley.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "พาร์สลีย์ เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefit": {
			"health": null,
			"food": null,
			"water": null
		},
		"details": {
			"0": "ช่วยแก้อาการคลื่นไส้อาเจียน",
			"1": "ช่วยขับเสมหะและละลายเสมหะ",
			"2": "ใช้เป็นยาขับปัสสาวะ",
			"3": "ใบมีสรรพคุณเป็นยาแก้อาการสะอึก",
			"4": "ช่วยลดระดับน้ำตาลในเลือด ลดความดันโลหิต"
		}
	},
	"918": {
		"name": "Thyme",
		"thai_name": "ไธม์",
		"icon": "res://assets/items/herb/thyme.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "ไทม์ เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefit": {
			"health": null,
			"food": null,
			"water": null
		},
		"details": {
			"0": "ช่วยบรรเทาอาการท้องร่วง",
			"1": "ช่วยบรรเทาอาการท้องใส้ปั่นป่วน",
			"2": "ช่วยบรรเทาอาการปวดท้อง",
			"3": "ช่วยบรรเทาโรคกระเพาะอาหารอักเสบ",
			"4": "ช่วยรักษาโรคกระเพาะอาหารอักเสบ"
		}
	},
	"919": {
		"name": "Winter Savory",
		"thai_name": "วินเทอร์ ซาวอรี่",
		"icon": "res://assets/items/herb/winter_savory.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "วินเทอร์ ซาวอรี่ เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefit": {
			"health": null,
			"food": null,
			"water": null
		},
		"details": {
			"0": "ช่วยลดก๊าซในกระเพาะอาหาร",
			"1": "ช่วยรักษาอาการไอและเจ็บคอ",
			"2": "แก้อาการอาหารไม่ย่อย",
			"3": "ช่วยรักษาอาการท้องร่วง",
			"4": "ช่วยรักษาอาการคลื่นไส้"
		}
	},
	"920": {
		"name": "Basil",
		"thai_name": "แบสอิล", # โหระพา
		"icon": "res://assets/items/herb/basil.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "แบสอิล หรือ โหระพา เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefit": {
			"health": null,
			"food": null,
			"water": null
		},
		"details": {
			"0": "ช่วยในการเจริญอาหาร",
			"1": "แก้อาการวิงเวียนศีรษะด้วยการนำใบมาต้มดื่ม",
			"2": "ช่วยรักษาโรคตาแดง ต้อตา มีขี้ตามาก",
			"3": "มีฤทธิ์ในการต่อต้านการอักเสบ",
			"4": "ช่วยแก้หวัดและช่วยในการขับเหงื่อ"
		}
	},
	"921": {
		"name": "Sage",
		"thai_name": "เสจ",
		"icon": "res://assets/items/herb/sage.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "เสจ เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefit": {
			"health": null,
			"food": null,
			"water": null
		},
		"details": {
			"0": "ช่วยรักษาอาการเบื่ออาหาร",
			"1": "แก้เจ็บคอ",
			"2": "รักษาแผลร้อนใน",
			"3": "ช่วยให้กล้ามเนื้อแข็งแรง",
			"4": "ช่วยเพิ่มสมาธิ ผ่อนคลายความวิตกกังวล"
		}
	},
	"922": {
		"name": "Chives",
		"thai_name": "ชิเวส", # ต้นหอมจีน
		"icon": "res://assets/items/herb/chives.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "ชิเวส หรือต้นหอมจีน เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefit": {
			"health": null,
			"food": null,
			"water": null
		},
		"details": {
			"0": "ช่วยบำรุงกระดูก",
			"1": "ช่วยลดระดับความดัน รักษาโรคความดันโลหิตสูง",
			"2": "ใช้เป็นยาแก้หวัด",
			"3": "ช่วยแก้ลมพิษ",
			"4": "ใบใช้ทาท้องเด็กช่วยแก้อาการท้องอืด"
		}
	},
	"923": {
		"name": "Oregano",
		"thai_name": "ออริกาโน",
		"icon": "res://assets/items/herb/oregano.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "ออริกาโน เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefit": {
			"health": null,
			"food": null,
			"water": null
		},
		"details": {
			"0": "ช่วยบรรเทาอาการปวดประจำเดือน",
			"1": "ช่วยบรรเทาอาการท้องอืด",
			"2": "ช่วยรักษาโรคปวดข้อ",
			"3": "ช่วยบรรเทาอาการท้องเฟ้อ",
			"4": "ช่วยบรรเทาอาการปวดหู"
		}
	},
	"924": {
		"name": "Catnip",
		"thai_name": "แคทนิป", # กัญชาแมว
		"icon": "res://assets/items/herb/catnip.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "แคทนิป หรือ กัญชาแมว เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefit": {
			"health": null,
			"food": null,
			"water": null
		},
		"details": {
			"0": "ช่วยลดอาการจุกเสียด",
			"1": "บรรเทาอาการไข้",
			"2": "ช่วยลดอาการปวดฟัน",
			"3": "ช่วยลดอาการปวดหัว",
			"4": "มีฤทธิ์ในการไล่แมลงสาบ ไล่ยุง และแมลงวัน"
		}
	},
	"925": {
		"name": "Sorrel",
		"thai_name": "ซอร์เรล",
		"icon": "res://assets/items/herb/sorrel.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "ซอร์เรล เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefit": {
			"health": null,
			"food": null,
			"water": null
		},
		"details": {
			"0": "ช่วยลดอาการปวดของโพรงจมูกและทางเดินหายใจ",
			"1": "ช่วยลดอาการบวม อักเสบเฉียบพลัน ของโพรงจมูกและทางเดินหายใจ",
			"2": "เพิ่มการขับถ่ายปัสสาวะ",
			"3": "ช่วยรักษาเชื้อแบคทีเรีย",
			"4": "ช่วยรักษาอาการไซนัส"
		}
	},
	"926": {
		"name": "Caraway",
		"thai_name": "คาราเวย์",
		"icon": "res://assets/items/herb/caraway.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "คาราเวย์ เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefit": {
			"health": null,
			"food": null,
			"water": null
		},
		"details": {
			"0": "ช่วยแก้อาการคลื่นไส้อาเจียน",
			"1": "ช่วยขับเสมหะ",
			"2": "เมล็ดมีสรรพคุณเป็นยาขับลม ช่วยขับลมในลำไส้เล็ก",
			"3": "ช่วยแก้อาการปวดหลัง แก้อาการเกร็ง",
			"4": "ช่วยแก้อาการปวดประจำเดือนของสตรี"
		}
	},
	"927": {
		"name": "Tarragon",
		"thai_name": "ทาร์รากอน",
		"icon": "res://assets/items/herb/tarragon.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "ทาร์รากอน เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefit": {
			"health": null,
			"food": null,
			"water": null
		},
		"details": {
			"0": "ช่วยจากหวัด",
			"1": "ลดความดัน สามารถใช้ในการรักษาความดันโลหิตสูง",
			"2": "บรรเทาความเครียดและความวิตกกังวล",
			"3": "เสริมสร้างกระดูก",
			"4": "ช่วยรักษาลิ่มเลือดอุดตันและเส้นเลือดขอด"
		}
	},
	"928": {
		"name": "Horseradish",
		"thai_name": "ฮอสแรดิช",
		"icon": "res://assets/items/herb/horseradish.png",
		"type": "quest",
		"weight": 0.0,
		"stackable": true,
		"stack_limit": 9999,
		"description": "ฮอสแรดิช เป็นสมุนไพรที่มีสรรพคุณต่างๆ และสามารถเพิ่มเลือดและอาหารได้",
		"sell_price": 0,
		"benefit": {
			"health": null,
			"food": null,
			"water": null
		},
		"details": {
			"0": "ทาลงบนผิวเพื่อรักษาอาการเจ็บข้อ",
			"1": "ทาลงบนผิวเพื่อรักษาอาการข้อบวม",
			"2": "ทาลงบนผิวเพื่อรักษาอาการเนื้อเยื่อบวม",
			"3": "ทาลงบนผิวเพื่อรักษาอาการปวดกล้ามเนื้อ",
			"4": "บรรเทาอาการปวดจากกระดูกทับเส้นประสาท"
		}
	},
}


# mint 915
# Rosemary 916 
# Parsley 917
# Thyme 918
# Winter Savory 919
# Basil 920
# Sage 921
# Chives 922
# Oregano 923
# Catnip 924
# Sorrel 925
# Caraway 926
# Tarragon 927
# Horseradish 928


var quest = {
	"001": {
		"npc_name": "mac",
		"quest_name": "ยินดีต้อนรับสู่หมู่บ้าน",
		"quest_dialog": {
			"0": "สวัสดี ยินดีต้อนรับสู่หมู่บ้านนะ ",
			"1": "เป็นยังไงบ้าง มาๆ เข้ามานี่ ข้าจะเล่าเรื่องต่างๆให้ฟัง",
			"2": "หมู่บ้านนี้น่ะ ไม่มีใครเข้าออกกันหรอกนะ",
			"3": "เจ้าจะไม่สามารถออกไปได้ เพราะป่าแถวนี้อันตรายมาก",
			"4": "แต่ก็มีทางที่จะทำให้เจ้ากลับบ้านได้ แต่ข้าไม่อยากให้เจ้าทำเลย ข้างนอกมันอันตรายนะ",
			"5": "ถ้าเจ้าอยากออกไปละก็ ช่วยคนในหมูบ้านนี้สิ เพราะเจ้ามีความสามารถในการเอาชีวิตรอดใช่ไหม แล้วหาวิธีล้างคำสาบให้สัตว์ดุร้ายหายไปซ่ะ",
			"6": "ถ้าตกลงละก็ มาเริ่มช่วยเหลือผู้คนกันเลย",
			"7": "น้องสาวของข้า เขาไม่ค่อยมีสมาธิเลย เขาเจ็บคอ และเขาทานอาหารไม่ได้ เบื่ออาหาร ช่วยรักษาเขาหน่อยได้ไหม"
		},
		"item_quest_require": {
			"0": "921", 
		},
		"rewards": {
			"money": 100,
			"exp": 100,
			"perk_point" : 5
		}
	},
	"002": {
		"npc_name": "dina",
		"quest_name": "เริ่มตั้งที่อยู่",
		"quest_dialog": {
			"0": "ช่วงนี้อากาศหนาวเย็นมาก",
			"1": "ช่วยหาไม้และหญ้ามาให้ข้าหน่อยสิ",
			"2": "ข้าว่าข้าจะเอามาเป็นเชื้อเพลิงจุดไฟน่ะ",
			"3": "ไม้เจ้าสามารถหาได้จากไม้ที่ล้ม และหญ้าหาได้ตรงกอหญ้านะ โชคดี"
		},
		"item_quest_require": {
			"0": "901",
			"1": "903" 
		},
		"rewards": {
			"money": 200,
			"exp": 200,
			"perk_point" : 5
		}
	},
	"003": {
		"npc_name": "bella",
		"quest_name": "เริ่มออกล่าสัตว์",
		"quest_dialog": {
			"0": "สวัสดี",
			"1": "ช่วงนี้หมู่บ้านเราขาดแคลนอาหารมาก",
			"2": "ช่วยหาเนื้อกวางและเนื้อกระต่ายมาให้เราหน่อยสิ"
		},
		"item_quest_require": {
			"0": "914", 
			"1": "913",
		},
		"rewards": {
			"money": 300,
			"exp": 300,
			"perk_point": 5
		}
	},
	"004": {
		"npc_name": "jacob",
		"quest_name": "สมุนไพรบำรุงท้อง",
		"quest_dialog": {
			"0": "สวัสดีคุณหมอ",
			"1": "ผมไม่รู้เป็นอะไรช่วงนี้ ปวดท้องบ่อยเหลือเกิน",
			"2": "ช่วยผมด้วยครับคุณหมอ"
		},
		"item_quest_require": {
			"0": "917",
			"1": "915" 
		},
		"rewards": {
			"money": 400,
			"exp": 400,
			"perk_point" : 5
		}
	},
	"005": {
		"npc_name": "jessy",
		"quest_name": "สมุนไพรใบที่สี่",
		"quest_dialog": {
			"0": "ช่วงนี้เหมือนข้าจะเป็นหวัด",
			"1": "ข้าต้องการสมุนไพรที่ช่วยแก้หวัด ช่วยหามาให้ฉันหน่อยสิ"
		},
		"item_quest_require": {
			"0": "922",
			"1": "927" 
		},
		"rewards": {
			"money": 500,
			"exp": 500,
			"perk_point" : 5
		}
	},
	"006": {
		"npc_name": "linda",
		"quest_name": "ออกหากัญชาแมว",
		"quest_dialog": {
			"0": "แมวของฉันไม่ค่อยราเริ่งเลย",
			"1": "มันดูเศร้าๆน่ะ",
			"2": "ช่วยดูให้ฉันหน่อยสิ",
			"3": "ขอบคุณมากๆนะ"
		},
		"item_quest_require": {
			"0": "923",
			"1": "924" 
		},
		"rewards": {
			"money": 600,
			"exp": 600,
			"perk_point" : 5
		}
	},
	"007": {
		"npc_name": "sophia",
		"quest_name": "สมุนไพร thyme และ winter savory",
		"quest_dialog": {
			"0": "สวัสดีผู้กล้า",
			"1": "ช่วยไปหาสมุนไพรมาให้ข้าหน่อย",
			"2": "ข้าต้องการสมุนไพรสองชนิดนี้",
			"3": "คือต้น thyme และ winter savory นะ"
		},
		"item_quest_require": {
			"0": "918",
			"1": "919" 
		},
		"rewards": {
			"money": 700,
			"exp": 700,
			"perk_point" : 5
		}
	},
	"008": {
		"npc_name": "ethan",
		"quest_name": "สมุนไพรชุดสุดท้าย",
		"quest_dialog": {
			"0": "สวัสดี",
			"1": "ช่วยไปหาสมุนไพรสามชนิดนี้มาให้ฉันหน่อยสิ",
			"2": "ขอบคุณมากๆนะ"
		},
		"item_quest_require": {
			"0": "926",
			"1": "921",
			"2": "928" 
		},
		"rewards": {
			"money": 800,
			"exp": 800,
			"perk_point" : 5
		}
	},
	"009": {
		"npc_name": "thomas",
		"quest_name": "ล่าหัวหน้าบอส",
		"quest_dialog": {
			"0": "สวัสดี ในที่สุดก็มาถึงทางสุดท้ายแล้วสินะ",
			"1": "อยากกลับบ้านละสิ",
			"2": "โลกแห่งนี้จะมีบอสหมาป่าอยู่ เพื่อที่จพทำให้สัตว์ดุร้ายกลับมาปกติ",
			"3": "ออกไปล่าบอสหมาป่า แล้วนายจะได้กลับบ้าน",
			"4": "บอสหมาป่าจะออกมาอยู่ทิศใต้ของหมู่บ้านนะ ลองเดินหาดู"
		},
		"item_quest_require": {
			"0": "999", 
		},
		"rewards": {
			"money": 900,
			"exp": 900,
			"perk_point" : 5
		}
	},
}

var npc = {
	"mac": {
		"name": "Mac",
		"type": "general_npc",
		"talk_dialog": {
			"0": "สวัสดี ฉันคือหัวหน้าของหมู่บ้านนี้ มีอะไรให้ช่วยหรือเปล่า",
		}
	},
	"bravo": {
		"name": "Bravo",
		"type": "merchant",
		"talk_dialog": {
			"0": "สวัสดี ! ! ! ต้องการอะไรหรือเปล่า มีหลายอย่างให้เลือกเลยนะ ลองเลือกดูได้เลย",
		}
	},
	"linda": {
		"name": "Linda",
		"type": "general_npc",
		"talk_dialog": {
			"0": "สวัสดี ฉัน Linda",
		}
	},
	"sophia": {
		"name": "Sophia",
		"type": "general_npc",
		"talk_dialog": {
			"0": "สวัสดี ฉัน Sophia",
		}
	},
	"tang": {
		"name": "Tang",
		"type": "general_npc",
		"talk_dialog": {
			"0": "สวัสดี ฉัน Tang , ฉันเป็นยามอยู่ที่นี่ มีอะไรให้ฉันช่วยหรือเปล่า",
		}
	},
	"dina": {
		"name": "Dina",
		"type": "general_npc",
		"talk_dialog": {
			"0": "สวัสดี ฉัน Dina",
		}
	},
	"bella": {
		"name": "Bella",
		"type": "general_npc",
		"talk_dialog": {
			"0": "สวัสดี ฉัน Bella",
		}
	},
	"jessy": {
		"name": "Jessy",
		"type": "general_npc",
		"talk_dialog": {
			"0": "สวัสดี ฉัน Jessy",
		}
	},
	"thomas": {
		"name": "Thomas",
		"type": "general_npc",
		"talk_dialog": {
			"0": "สวัสดี ฉัน Thomas",
		}
	},
	"jacob": {
		"name": "Jacob",
		"type": "general_npc",
		"talk_dialog": {
			"0": "สวัสดี ฉัน Jacob",
		}
	},
	"ethan": {
		"name": "Ethan",
		"type": "general_npc",
		"talk_dialog": {
			"0": "สวัสดี ฉัน Ethan",
		}
	},
}

var equipment = {
	"rifle": {
		"1": {
			"name": "Winchester XPR",
			"texture": "res://assets/equipment/rifle/winchester_xpr.png",
			"texture_interface" : "res://assets/equipment_interface/rifle/winchester_xpr.png",
			"sound": "xxx",
			"damage": 0,
			"price": 0,
			"level": 1
		},
		"2": {
			"name": "Savage 12 LRP",
			"texture": "res://assets/equipment/rifle/savage_12_LRP.png",
			"texture_interface" : "res://assets/equipment_interface/rifle/savage_12_LRP.png",
			"sound": "xxx",
			"damage": 0,
			"price": 0,
			"level": 1
		},
		"3": {
			"name": "Remington 700 SPS",
			"texture": "res://assets/equipment/rifle/remington_700_SPS.png",
			"texture_interface" : "res://assets/equipment_interface/rifle/remington_700_SPS.png",
			"sound": "xxx",
			"damage": 0,
			"price": 0,
			"level": 1
		}
	},
	"pistol": {
		"1": {
			"name": "M1911",
			"texture" : "res://assets/equipment/pistol/m1911.png",
			"texture_interface" : "res://assets/equipment_interface/pistol/m1911_interface.png",
			"sound": "xxx",
			"damage": 0,
			"price": 0,
			"level": 1
		},
		"2": {
			"name": "CZ75",
			"texture" : "res://assets/equipment/pistol/cz75.png",
			"texture_interface" : "res://assets/equipment_interface/pistol/cz75_interface.png",
			"sound": "xxx",
			"damage": 0,
			"price": 0,
			"level": 1
		},
		"3": {
			"name": "Sig Sauer P320sp",
			"texture" : "res://assets/equipment/pistol/sig_sauer_p320sp.png",
			"texture_interface" : "res://assets/equipment_interface/pistol/sig_sauer_p320sp_interface.png",
			"sound": "xxx",
			"damage": 0,
			"price": 0,
			"level": 1
		}
	},
	"knife": {
		"1": {
			"name": "Knife",
			"texture" : "res://assets/equipment_interface/knife/knife_1.png",
			"sound": "xxx",
			"damage": 0,
			"price": 0,
			"level": 1,
		}
	},
	"binoculars": {
		"1": {
			"name": "Binoculars",
			"texture" : "res://assets/equipment_interface/binoculars/binoculars_1.png",
			"price": 0,
			"level": 1,
		}
	},
	"calling_device": {
		"1": {
			"name": "Moose Deer Call",
			"texture" : "res://assets/equipment_interface/calling_device/moose_call.png",
			"sound": "xxx",
			"call_type": "deer",
			"price": 0,
			"level": 1
		},
#		"2": {
#			"name": "Calling Device 2",
#			"texture" : "res://assets/equipment_interface/calling_device/calling_device_2.png",
#			"call_type": "bear",
#			"sound": "xxx",
#			"price": 0,
#			"level": 1
#		}
	},
	"shovel": {
		"1": {
			"name": "Shovel",
			"texture" : "res://assets/equipment_interface/shovel/shovel.png",
			"price": 0,
			"level": 1
		}
	}
}

var perk = {
	"0": {
		"name": "Run Speed Up",
		"description": "เพิ่มความเร็วในการเคลื่อนที่",
		"icon": "res://assets/icons/perk/run_speed_up.png",
		"perk_point_req": 1,
		"max_progress": 5,
	},
	"1": {
		"name": "Health Up",
		"description": "เพิ่มเลือด",
		"icon": "res://assets/icons/perk/health_up.png",
		"perk_point_req": 1,
		"max_progress": 5,
	},
	"2": {
		"name": "Decreased Thirst Rate",
		"description": "อัตราการกระหายน้ำลดลง",
		"icon": "res://assets/icons/perk/water_up.png",
		"perk_point_req": 1,
		"max_progress": 5,
	},
	"3": {
		"name": "Reduced Hunger Rate",
		"description": "อัตราการหิวลดลง",
		"icon": "res://assets/icons/perk/food_up.png",
		"perk_point_req": 1,
		"max_progress": 5,
	},
	"4": {
		"name": "Sniper Dagage Up",
		"description": "เพิ่มความแรงของปืนสไนเปอร์",
		"icon": "res://assets/icons/perk/sniper_damage_up.png",
		"perk_point_req": 1,
		"max_progress": 5,
	},
	"5": {
		"name": "Pistol Damage Up",
		"description": "เพิ่มความแรงของปืนพก",
		"icon": "res://assets/icons/perk/pistol_damage_up.png",
		"perk_point_req": 1,
		"max_progress": 5,
	},
	"6": {
		"name": "Knife Damage Up",
		"description": "เพิ่มความแรงของมีด",
		"icon": "res://assets/icons/perk/knife_damage_up.png",
		"perk_point_req": 1,
		"max_progress": 5,
	},
	"7": {
		"name": "Increase Hearing Rate",
		"description": "เพิ่มอัตราการได้ยิน",
		"icon": "res://assets/icons/perk/increase_hearing_rate.png",
		"perk_point_req": 1,
		"max_progress": 5,
	}
}
# 1375

var shop = {
	"0": {
		"thai_name": "กระสุนสไนเปอร์",
		"price": 5000,
		"item_id": null,
		"icon": "res://assets/icons/sniper_ammo.png",
	},
	"1": {
		"thai_name": "กระสุนปืนพก",
		"price": 5090,
		"item_id": null,
		"icon": "res://assets/icons/pistol_ammo.png",
	},
	"2": {
		"thai_name": "ขวดเปล่า",
		"price": 5000,
		"item_id": "104",
		"icon": "res://assets/items/material/empty_bottle.png"
	},
	"3": {
		"thai_name": "เชือก",
		"price": 5080,
		"item_id": "102",
		"icon": "res://assets/items/material/rope.png",
	}
}
