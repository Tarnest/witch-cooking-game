extends Panel

@onready var item_visual = $Sprite2D

var current_item: InventoryItem

func update(item: InventoryItem):
	if !item:
		visible = false
	else:
		visible = true
		item_visual.texture = item.texture
		current_item = item
