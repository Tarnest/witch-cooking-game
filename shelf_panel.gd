extends PanelContainer

signal button_clicked(item)

func _on_eyeball_pressed():
	button_clicked.emit("eyeball")
