extends Resource
class_name Recipe

@export var ingredients: Array[InventoryItem]
@export var name: String = ""

func set_ingredients(_ingredients):
	ingredients = _ingredients

func get_recipe_name(possible_recipes: Array[Recipe]) -> String:
	for recipe in possible_recipes:
		if check_array(recipe.ingredients, self.ingredients):
			return recipe.name
	return ""

func check_array(arr1, arr2) -> bool:
	return arr1 == arr2

	
