extends CanvasLayer

@export var object: PanelContainer

func _on_open(container):
	object.visible = true


func _on_close_pressed():
	object.visible = false
