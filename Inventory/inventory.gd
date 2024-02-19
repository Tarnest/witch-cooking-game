extends Resource
class_name Inventory

signal update

@export var slots: Array[InventorySlot]
@export var max_items: int = 3
@export var possible_items: Array[InventoryItem]

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

func check_item(item_name: String):
	for item in possible_items:
		if item.name == item_name:
			insert(item)
