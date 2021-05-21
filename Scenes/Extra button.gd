extends Button



func _on_Extra_button_pressed():
	get_tree().change_scene("res://Scenes/Extra.tscn")


func _on_Extra_button_mouse_entered():
	get_node("Extra").set_text("View")


func _on_Extra_button_mouse_exited():
	get_node("Extra").set_text("Extra")
