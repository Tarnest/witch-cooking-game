extends Node2D

signal open_menu
signal add_item_to_pot(item: InventoryItem)

@onready var player_inventory = preload("res://Player/player_inventory.tres")
@onready var slot_size = $CanvasLayer/PanelContainer/VBoxContainer/ToCraft/GridContainer.get_children().size()

@onready var red_potion = preload("res://Objects/InventoryItems/CauldronProducts/RedPotion/red_potion.tres")

@onready var recipes: Array[Recipe] = [red_potion.recipe]
@onready var recipe_items: Array[InventoryItem] = [red_potion]

var object_closed = true
var items_in_pot: Dictionary


func open():
	open_menu.emit()
	object_closed = false


func _on_close_pressed():
	object_closed = true


func use_item(item_name):
	var item = player_inventory.get_item(item_name)
	# check if pot is full
	var values = items_in_pot.values()
	
	var sum: int = 0
	for value in values:
		sum += value
	
	if item != null && sum < slot_size:
		player_inventory.remove(item)
		add_to_pot(item)


func add_to_pot(item: InventoryItem):
	if items_in_pot.has(item):
		items_in_pot[item] += 1
	else:
		items_in_pot[item] = 1
	add_item_to_pot.emit(items_in_pot)


func _on_confirm_pressed():
	var item: InventoryItem = check_recipe()
	if item != null:
		player_inventory.insert(item)
	
	items_in_pot.clear()


func check_recipe() -> InventoryItem:
	var recipe: Recipe = Recipe.new()
	recipe.set_ingredients(items_in_pot)
	
	var recipe_name = recipe.get_recipe_name(recipes)
	for item in recipe_items:
		if item.name == recipe_name:
			return item
	return null
