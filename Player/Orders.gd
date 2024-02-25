extends CanvasLayer

@onready var slots1: Array = $VBoxContainer/NinePatchRect/Customer1.get_children()
@onready var slots2: Array = $VBoxContainer/NinePatchRect/Customer2.get_children()
@onready var slots3: Array = $VBoxContainer/NinePatchRect/Customer3.get_children()
@onready var slots_arr: Array = [slots1, slots2, slots3]

func _on_player_customer_order(order: Dictionary):
	var order_arr = dict_to_arr(order)
	var current_slots: Array
	
	for slots in slots_arr:
		for slot in slots:
			if !slot.visible:
				current_slots = slots
				break
		
		if !current_slots.is_empty():
			break
	
	if current_slots.is_empty():
		return
	
	for i in range(order_arr.size()):
		current_slots[i].update(order_arr[i])
	

func _on_player_give_customer_order():
	pass # Replace with function body.


func dict_to_arr(dict: Dictionary) -> Array:
	var arr: Array = []
	for item in dict:
		for i in range(dict[item]):
			arr.append(item)
	return arr
