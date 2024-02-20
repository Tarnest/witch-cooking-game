extends PanelContainer

signal button_clicked(item)

func _on_eyeball_pressed():
	button_clicked.emit("eyeball")


func _on_ruby_pressed():
	button_clicked.emit("ruby")
