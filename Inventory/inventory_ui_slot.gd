extends PanelContainer

@onready var item_visual: Sprite2D = $CenterContainer/Panel/ItemDisplay
@onready var amount: Label = $CenterContainer/Panel/Amount

func update(slot: InventorySlot):
	if !slot.item:
		item_visual.visible = false
		amount.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		
		if slot.amount > 1:
			amount.visible = true
			amount.text = str(slot.amount)
