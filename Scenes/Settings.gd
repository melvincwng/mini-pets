extends Node

# Declare member variables here. Examples:
# To find this file, go to C:\Users\<username>\AppData\Roaming\Godot\app_userdata\Mini Pets
var settings_file = "user://settings.save"
var soundOn;

func load_sound_settings():
	var file = File.new()
	# For players who received the V2.1 update & are NOT THE FIRST TIME opening the app (aka already got this new settings.save file)
	if file.file_exists(settings_file):
		file.open(settings_file, File.READ)
		soundOn = file.get_var()
	# For players who received the V2.1 update but are opening the app THE FIRST TIME (aka do not have this new settings.save file)
	else:
		# File.WRITE creates the file for it doesn't exist. If it already exists, you can open the file to change it
		# Reference: https://godotengine.org/qa/69677/error-trying-to-open-a-file-what-am-i-doing-wrong 
		file.open(settings_file, File.WRITE)
		soundOn = true
		file.store_var(soundOn)
	# print("What is the value of soundOn variable: " + str(soundOn))
	
func toggle_sound(soundVariable):
	if soundVariable == true:
		var masterAudioBusIndex = AudioServer.get_bus_index("Master") # Grabs the index of the Master Audio Bus aka the main audio channel we are using
		AudioServer.set_bus_mute(masterAudioBusIndex, false) # Unmute the main audio channel
	else:
		var masterAudioBusIndex = AudioServer.get_bus_index("Master") # Grabs the index of the Master Audio Bus aka the main audio channel we are using
		AudioServer.set_bus_mute(masterAudioBusIndex, true) # Mute the main audio channel

# A utility function to be exported to MainScene.gd which will be triggered when the user clicks the 'Sound: On/Off' button
func save_sound_settings(soundVariable):
	var file = File.new()
	file.open(settings_file, File.WRITE)
	file.store_var(soundVariable)
	file.close()
	
# A utility function exported to MainScene.gd to change text of sound button when pressed
func toggle_sound_button_text(soundVariable, soundButtonTextNode):
	if soundVariable == true:
		soundButtonTextNode.text = "Sound: On"
	else:
		soundButtonTextNode.text = "Sound: Off"
		
# Called when the node enters the scene tree for the first time.
func _ready():
	load_sound_settings()
	toggle_sound(soundOn)
