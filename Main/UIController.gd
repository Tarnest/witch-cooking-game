extends CanvasLayer


func _on_open(container):
	if container == "shelf":
		$Shelf.visible = true
