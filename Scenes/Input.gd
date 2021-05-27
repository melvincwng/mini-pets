extends LineEdit

func _ready():
	pass
	# when the line-edit node loads, using grab_focus() will automatically focus on the line-edit node
	# hence allowing users to type immediately
	# but I removed/commented it 
	# cause in mobile phones, it will automatically open the keyboard panel (distracting)
	# Hence, now users can type still but only if they click the line-edit node area
	# grab_focus()

func _on_Input_text_entered(new_text):
	clear()
