extends Control

onready var admob = $AdMob


# Called when the node enters the scene tree for the first time.
func _ready():
	admob.load_banner()
	admob.show_banner()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
