extends Resource
class_name Inventory

signal update

@export var slots: Array[InventorySlot]
@export var max_items: int = 3

var eyeball = preload("res://Objects/InventoryItems/Eyeball/eyeball.tres")
var ruby = preload("res://Objects/InventoryItems/Ruby/ruby.tres")

var possible_items: Array[InventoryItem] = [eyeball, ruby]

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
