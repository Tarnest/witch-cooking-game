extends CanvasLayer

@onready var object = $PanelContainer


func _on_open():
	object.visible = true


func _on_close_pressed():
	object.visible = false
