extends Node2D

signal open_menu
signal add_item_to_pot(item: InventoryItem)

@onready var player_inventory = preload("res://Player/player_inventory.tres")
@onready var slot_size = $CanvasLayer/PanelContainer/VBoxContainer/ToCraft/GridContainer.get_children().size()

var black_potion = preload("res://Objects/InventoryItems/CauldronProducts/BlackPotion/black_potion.tres")
var blue_potion = preload("res://Objects/InventoryItems/CauldronProducts/BluePotion/blue_potion.tres")
var dark_green_potion = preload("res://Objects/InventoryItems/CauldronProducts/DarkGreenPotion/dark_green_potion.tres")
var green_potion = preload("res://Objects/InventoryItems/CauldronProducts/GreenPotion/green_potion.tres")
var orange_potion = preload("res://Objects/InventoryItems/CauldronProducts/OrangePotion/orange_potion.tres")
var pink_potion = preload("res://Objects/InventoryItems/CauldronProducts/PinkPotion/pink_potion.tres")
var purple_potion = preload("res://Objects/InventoryItems/CauldronProducts/PurplePotion/purple_potion.tres")
var red_potion = preload("res://Objects/InventoryItems/CauldronProducts/RedPotion/red_potion.tres")
var white_potion = preload("res://Objects/InventoryItems/CauldronProducts/WhitePotion/white_potion.tres")
var yellow_potion = preload("res://Objects/InventoryItems/CauldronProducts/YellowPotion/yellow_potion.tres")

var broach = preload("res://Objects/InventoryItems/CraftStationItems/Broach/broach.tres")
var clock = preload("res://Objects/InventoryItems/CraftStationItems/Clock/clock.tres")
var cross = preload("res://Objects/InventoryItems/CraftStationItems/Cross/cross.tres")
var dagger = preload("res://Objects/InventoryItems/CraftStationItems/Dagger/dagger.tres")
var feather_pen = preload("res://Objects/InventoryItems/CraftStationItems/FeatherPen/feather_pen.tres")
var hook = preload("res://Objects/InventoryItems/CraftStationItems/Hook/hook.tres")
var horseshoe = preload("res://Objects/InventoryItems/CraftStationItems/Horseshoe/horseshoe.tres")
var key = preload("res://Objects/InventoryItems/CraftStationItems/Key/key.tres")
var rabbit_foot = preload("res://Objects/InventoryItems/CraftStationItems/RabbitFoot/rabbit_foot.tres")
var ring = preload("res://Objects/InventoryItems/CraftStationItems/Ring/ring.tres")

var ritual1 = preload("res://Objects/InventoryItems/PentagramItems/Ritual1/ritual1.tres")
var ritual2 = preload("res://Objects/InventoryItems/PentagramItems/Ritual2/ritual2.tres")
var ritual3 = preload("res://Objects/InventoryItems/PentagramItems/Ritual3/ritual3.tres")
var ritual4 = preload("res://Objects/InventoryItems/PentagramItems/Ritual4/ritual4.tres")
var ritual5 = preload("res://Objects/InventoryItems/PentagramItems/Ritual5/ritual5.tres")

var cauldron_recipes: Array[Recipe] = [black_potion.recipe, blue_potion.recipe, dark_green_potion.recipe, green_potion.recipe, orange_potion.recipe, pink_potion.recipe, purple_potion.recipe, white_potion.recipe, yellow_potion.recipe, red_potion.recipe]
var pentagram_recipes: Array[Recipe] = [ritual1.recipe, ritual2.recipe, ritual3.recipe, ritual4.recipe, ritual5.recipe]
var work_table_recipes: Array[Recipe] = [broach.recipe, clock.recipe, cross.recipe, dagger.recipe, feather_pen.recipe, hook.recipe, horseshoe.recipe, key.recipe, rabbit_foot.recipe, ring.recipe]
@onready var recipe_items: Array[InventoryItem] = player_inventory.possible_items

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
	var recipe_name
	if is_in_group("Cauldron"):
		recipe_name = recipe.get_recipe_name(cauldron_recipes)
	elif is_in_group("Pentagram"):
		recipe_name = recipe.get_recipe_name(pentagram_recipes)
	elif is_in_group("WorkTable"):
		recipe_name = recipe.get_recipe_name(work_table_recipes)
	
	for item in recipe_items:
		if item.name == recipe_name:
			return item
	return null
