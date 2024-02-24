extends Resource
class_name Recipe

@export var ingredients: Dictionary
@export var name: String = ""

func set_ingredients(_ingredients):
	ingredients = _ingredients

func get_recipe_name(possible_recipes: Array[Recipe]) -> String:
	for recipe in possible_recipes:
		if check_recipe(recipe.ingredients, self.ingredients):
			return recipe.name
	return ""

func check_recipe(recipe1: Dictionary, recipe2: Dictionary) -> bool:
	return recipe1 == recipe2


