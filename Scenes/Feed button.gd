extends Button

# 12 hour cooldown time (in seconds here) after clicking any of the feed, play or clean buttons
var time_limit = 43200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_Feed_button_pressed():
	Signal.emit_signal("feed_pet")
