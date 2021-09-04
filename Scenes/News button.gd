extends Button



func _on_News_button_pressed():
	OS.shell_open("https://sites.google.com/view/mini-pets-news")


func _on_News_button_mouse_entered():
	get_node("News").set_text("View")


func _on_News_button_mouse_exited():
	get_node("News").set_text("News")
