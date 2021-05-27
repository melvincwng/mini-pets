extends LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	# when the line-edit node loads, it will automatically allow us to type
	grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Input_text_entered(new_text):
	clear()
