extends Button

func _on_Instructions_button_pressed():
	get_tree().change_scene("res://Scenes/Instructions.tscn")

func _on_Instructions_button_mouse_entered():
	get_node("Instructions").set_text("View")

func _on_Instructions_button_mouse_exited():
	get_node("Instructions").set_text("How to Play")
