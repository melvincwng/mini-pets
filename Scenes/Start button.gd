extends Button

func _on_Start_button_pressed():
	get_tree().change_scene("res://Scenes/MainScene.tscn")


func _on_Start_button_mouse_entered():
	get_node("Start").set_text("Ready")


func _on_Start_button_mouse_exited():
	get_node("Start").set_text("Start")
