extends PanelContainer

signal button_clicked(item)

func _on_eyeball_pressed():
	button_clicked.emit("eyeball")


func _on_ruby_pressed():
	button_clicked.emit("ruby")


func _on_limestone_pressed():
	button_clicked.emit("limestone")


func _on_twig_pressed():
	button_clicked.emit("twig")


func _on_gold_pressed():
	button_clicked.emit("gold")


func _on_bottle_pressed():
	button_clicked.emit("bottle")


func _on_rope_pressed():
	button_clicked.emit("rope")


func _on_paper_pressed():
	button_clicked.emit("paper")


func _on_silver_pressed():
	button_clicked.emit("silver")


func _on_chicken_foot_pressed():
	button_clicked.emit("chicken_foot")


func _on_lizard_tongue_pressed():
	button_clicked.emit("lizard_tongue")


func _on_wax_pressed():
	button_clicked.emit("wax")


func _on_tongue_pressed():
	button_clicked.emit("tongue")


func _on_emerald_pressed():
	button_clicked.emit("emerald")


func _on_feather_pressed():
	button_clicked.emit("feather")


func _on_horn_pressed():
	button_clicked.emit("horn")
