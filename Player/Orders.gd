extends CanvasLayer

@onready var slots1: Array = $VBoxContainer/NinePatchRect/Customer1.get_children()
@onready var slots2: Array = $VBoxContainer/NinePatchRect/Customer2.get_children()
@onready var slots3: Array = $VBoxContainer/NinePatchRect/Customer3.get_children()
@onready var slots_arr: Array = [slots1, slots2, slots3]

func _on_player_customer_order(order: Dictionary):
	var order_arr = dict_to_arr(order)
	var current_slots: Array
	
	for slots in slots_arr:
		if !slots[0].visible:
			current_slots = slots
			break
	
	if current_slots.is_empty():
		return
	
	for i in range(order_arr.size()):
		current_slots[i].update(order_arr[i])
	

func _on_player_give_customer_order():
	for i in range(slots2.size()):
		slots1[i].update(slots2[i].current_item)
	
	for i in range(slots3.size()):
		slots2[i].update(slots3[i].current_item)
	
	for slot in slots3:
		slot.visible = false
	


func dict_to_arr(dict: Dictionary) -> Array:
	var arr: Array = []
	for item in dict:
		for i in range(dict[item]):
			arr.append(item)
	return arr
