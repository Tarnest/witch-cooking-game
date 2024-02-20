extends Panel

@onready var sprite = $Sprite2D

func update(item: InventoryItem):
	if !item:
		visible = false
	else:
		visible = true
		sprite.texture = item.texture
