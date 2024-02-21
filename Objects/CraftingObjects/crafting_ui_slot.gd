extends TextureButton

signal use(item_name: String)

@onready var amount: Label = $Amount
var current_slot: InventorySlot

func update(slot: InventorySlot):
	if !slot.item:
		visible = false
		amount.visible = false
		current_slot = null
	else:
		visible = true
		texture_normal = slot.item.texture
		if slot.item.hover_texture != null:
			texture_hover = slot.item.hover_texture
		current_slot = slot
		
		if slot.amount > 1:
			amount.visible = true
			amount.text = str(slot.amount)
		else:
			amount.visible = false


func _on_pressed():
	use.emit(current_slot.item.name)
