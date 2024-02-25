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

var red_potion = preload("res://Objects/InventoryItems/CauldronProducts/RedPotion/red_potion.tres")

var possible_items: Array[InventoryItem] = [eyeball, ruby, red_potion]

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
