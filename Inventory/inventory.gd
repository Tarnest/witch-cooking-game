extends Resource
class_name Inventory

signal update

@export var slots: Array[InventorySlot]
@export var max_items: int = 3

var aloe = preload("res://Objects/InventoryItems/FarmItems/Aloe/aloe.tres")
var apple = preload("res://Objects/InventoryItems/FarmItems/Apple/apple.tres")
var rose = preload("res://Objects/InventoryItems/FarmItems/Rose/rose.tres")
var sage = preload("res://Objects/InventoryItems/FarmItems/Sage/sage.tres")
var tulip = preload("res://Objects/InventoryItems/FarmItems/Tulip/tulip.tres")

var bottle = preload("res://Objects/InventoryItems/ShelfItems/Bottle/bottle.tres")
var chicken_foot = preload("res://Objects/InventoryItems/ShelfItems/ChickenFoot/chicken_foot.tres")
var emerald = preload("res://Objects/InventoryItems/ShelfItems/Emerald/emerald.tres")
var eyeball = preload("res://Objects/InventoryItems/ShelfItems/Eyeball/eyeball.tres")
var feather = preload("res://Objects/InventoryItems/ShelfItems/Feather/feather.tres")
var gold = preload("res://Objects/InventoryItems/ShelfItems/Gold/gold.tres")
var horn = preload("res://Objects/InventoryItems/ShelfItems/Horn/horn.tres")
var limestone = preload("res://Objects/InventoryItems/ShelfItems/Limestone/limestone.tres")
var lizard_tail = preload("res://Objects/InventoryItems/ShelfItems/LizardTail/lizard_tail.tres")
var paper = preload("res://Objects/InventoryItems/ShelfItems/Paper/paper.tres")
var rope = preload("res://Objects/InventoryItems/ShelfItems/Rope/rope.tres")
var ruby = preload("res://Objects/InventoryItems/ShelfItems/Ruby/ruby.tres")
var tongue = preload("res://Objects/InventoryItems/ShelfItems/Tongue/tongue.tres")
var twig = preload("res://Objects/InventoryItems/ShelfItems/Twig/twig.tres")
var wax = preload("res://Objects/InventoryItems/ShelfItems/Wax/wax.tres")

var black_potion = preload("res://Objects/InventoryItems/CauldronProducts/BlackPotion/black_potion.tres")
var blue_potion = preload("res://Objects/InventoryItems/CauldronProducts/BluePotion/blue_potion.tres")
var dark_green_potion = preload("res://Objects/InventoryItems/CauldronProducts/DarkGreenPotion/dark_green_potion.tres")
var green_potion = preload("res://Objects/InventoryItems/CauldronProducts/GreenPotion/green_potion.tres")
var orange_potion = preload("res://Objects/InventoryItems/CauldronProducts/OrangePotion/orange_potion.tres")
var pink_potion = preload("res://Objects/InventoryItems/CauldronProducts/PinkPotion/pink_potion.tres")
var purple_potion = preload("res://Objects/InventoryItems/CauldronProducts/PurplePotion/purple_potion.tres")
var red_potion = preload("res://Objects/InventoryItems/CauldronProducts/RedPotion/red_potion.tres")
var white_potion = preload("res://Objects/InventoryItems/CauldronProducts/WhitePotion/white_potion.tres")
var yellow_potion = preload("res://Objects/InventoryItems/CauldronProducts/YellowPotion/yellow_potion.tres")

var broach = preload("res://Objects/InventoryItems/CraftStationItems/Broach/broach.tres")
var clock = preload("res://Objects/InventoryItems/CraftStationItems/Clock/clock.tres")
var cross = preload("res://Objects/InventoryItems/CraftStationItems/Cross/cross.tres")
var dagger = preload("res://Objects/InventoryItems/CraftStationItems/Dagger/dagger.tres")
var feather_pen = preload("res://Objects/InventoryItems/CraftStationItems/FeatherPen/feather_pen.tres")
var hook = preload("res://Objects/InventoryItems/CraftStationItems/Hook/hook.tres")
var horseshoe = preload("res://Objects/InventoryItems/CraftStationItems/Horseshoe/horseshoe.tres")
var key = preload("res://Objects/InventoryItems/CraftStationItems/Key/key.tres")
var rabbit_foot = preload("res://Objects/InventoryItems/CraftStationItems/RabbitFoot/rabbit_foot.tres")
var ring = preload("res://Objects/InventoryItems/CraftStationItems/Ring/ring.tres")

var ritual1 = preload("res://Objects/InventoryItems/PentagramItems/Ritual1/ritual1.tres")
var ritual2 = preload("res://Objects/InventoryItems/PentagramItems/Ritual2/ritual2.tres")
var ritual3 = preload("res://Objects/InventoryItems/PentagramItems/Ritual3/ritual3.tres")
var ritual4 = preload("res://Objects/InventoryItems/PentagramItems/Ritual4/ritual4.tres")
var ritual5 = preload("res://Objects/InventoryItems/PentagramItems/Ritual5/ritual5.tres")

var possible_items: Array[InventoryItem] = [aloe, apple, rose, sage, tulip, bottle, chicken_foot, emerald, eyeball, feather, gold, horn, limestone, lizard_tail, paper, rope, ruby, tongue, twig, wax, black_potion, blue_potion, dark_green_potion, green_potion, orange_potion, pink_potion, purple_potion, red_potion, white_potion, yellow_potion, broach, clock, cross, dagger, feather_pen, hook, horseshoe, key, rabbit_foot, ring, ritual1, ritual2, ritual3, ritual4, ritual5]

func insert(item: InventoryItem):
	var item_slots = slots.filter(func(slot): return slot.item == item)
	if !item_slots.is_empty():
		if item_slots[0].amount < max_items:
			item_slots[0].amount += 1
	else:
		var empty_slots = slots.filter(func(slot): return slot.item == null)
		if !empty_slots.is_empty():
			empty_slots[0].item = item
			empty_slots[0].amount = 1
	update.emit()

func remove(item: InventoryItem):	
	var item_slots = slots.filter(func(slot): return slot.item == item)
	
	if item_slots.is_empty():
		return
	
	item_slots[0].amount -= 1
	
	if item_slots[0].amount == 0:
		item_slots[0].item = null
	
	update.emit()

func get_item(item_name: String) -> InventoryItem:
	for item in possible_items:
		if item.name == item_name:
			return item
	return null

func clear():
	for slot in slots:
		slot.item = null
		slot.amount = 0
	update.emit()

func is_empty() -> bool:
	return !slots.size()
