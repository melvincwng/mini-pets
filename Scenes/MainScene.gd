extends Node2D

# need to save these variables
var level = 0
var food_counter = 0
var mood_counter = 0
var clean_counter = 0
#need to be able to save this random_number so that the system can remember if the player has a chance to transform into the rare fire slime
var random_number
# need to find a way to store this... so the system knows how to calculate the number of days the pet has been growing
var startDay
var gameData_file = "user://gameData.save"
var clickFeedButtonTime
var clickPlayButtonTime
var clickCleanButtonTime


onready var dateLabel = $Date
onready var timeLabel = $Time
onready var dayLabel = $Day
onready var levelLabel = $Level
onready var foodLabel = $Food
onready var moodLabel = $Mood
onready var cleanLabel = $Clean
onready var sprite = $Player
onready var admob = $AdMob


# Called when the node enters the scene tree for the first time.
func _ready():
	Signal.connect("feed_pet", self, "feed_increase_level")
	Signal.connect("play_pet", self, "play_increase_level")
	Signal.connect("clean_pet", self, "clean_increase_level")
	sprite.play("IdleBlack")
	load_data()
	admob.load_banner()
	admob.show_banner()
	
	
func save_data():
	var file = File.new()
	file.open(gameData_file, File.WRITE)
	file.store_var(level)
	file.store_var(food_counter)
	file.store_var(mood_counter)
	file.store_var(clean_counter)
	file.store_var(random_number)
	file.store_var(startDay)
	file.store_var(clickFeedButtonTime)
	file.store_var(clickPlayButtonTime)
	file.store_var(clickCleanButtonTime)
	file.close()
	
	
	
func load_data():
	var file = File.new()
	if file.file_exists(gameData_file):
		file.open(gameData_file, File.READ)
		level = file.get_var()
		food_counter = file.get_var()
		mood_counter = file.get_var()
		clean_counter = file.get_var()
		random_number = file.get_var()
		startDay = file.get_var()
		clickFeedButtonTime = file.get_var()
		clickPlayButtonTime = file.get_var()
		clickCleanButtonTime = file.get_var()
		file.close()
	else:
		level = 0
		food_counter = 0
		mood_counter = 0
		clean_counter = 0
		random_number = random_number_generator()
		startDay = OS.get_unix_time()
		
		
# This is similar to useEffect hook in JS
# when line 90+ aka the transparent slime "Idle" animation ends
# this function func _on_Player_animation_finished() will automatically run
# to play the correct animated slime based on the level of the player	
func _on_Player_animation_finished():
	if level < 30:
		sprite.play("IdleBlack")
	elif level >= 30 and level < 60:
		sprite.play("IdleBlue")
	elif level >= 60 and level < 90:
		sprite.play("IdleRed")
	elif level >= 90 and level < 120:
		sprite.play("IdleGreen")
	elif level >= 120 and level < 150:
		sprite.play("IdleGrey")	
	elif level >= 150 and level < 180:
		sprite.play("Idle")
	else:
		if random_number == 88:
			sprite.play("IdleFire")
		else:
			sprite.play("IdleMetal")
			
			
func feed_increase_level():
	$Player/feedSound.play()
	level += 0.25
	var levelString = "Level: " + str(level) + " #"
	levelLabel.clear()
	levelLabel.set_text(levelString)
	
	food_counter += 1
	var foodString = "Food Counter: " + str(food_counter)
	foodLabel.clear()
	foodLabel.set_text(foodString)
	
	evolve_pet_feed()
	
	# disable the feed button for 8 hours (28800 seconds) after clicking
	clickFeedButtonTime = OS.get_unix_time()
	$"Feed button".disabled = true
	
	
	
func play_increase_level():
	$Player/playSound.play()
	level += 0.15
	var levelString = "Level: " + str(level) + " #"
	levelLabel.clear()
	levelLabel.set_text(levelString)
	
	mood_counter += 1
	var moodString = "Mood Counter: " + str(mood_counter)
	moodLabel.clear()
	moodLabel.set_text(moodString)
	
	evolve_pet_play()
	
	# disable the play button for 8 hours after clicking
	clickPlayButtonTime = OS.get_unix_time()
	$"Play button".disabled = true
	
	
func clean_increase_level():
	$Player/cleanSound.play()
	level += 0.1
	var levelString = "Level: " + str(level) + " #"
	levelLabel.clear()
	levelLabel.set_text(levelString)
	
	clean_counter += 1
	var cleanString = "Clean Counter: " + str(clean_counter)
	cleanLabel.clear()
	cleanLabel.set_text(cleanString)

	evolve_pet_clean()
	
	#disable the clean button 8 hours after clicking
	clickCleanButtonTime = OS.get_unix_time()
	$"Clean button".disabled = true
	
	
func evolve_pet_feed():
	if level < 30:
		sprite.play("FeedBlack")
	elif level >= 30 and level < 60:
		sprite.play("FeedBlue")
	elif level >=60 and level < 90:
		sprite.play("FeedRed")
	elif level >= 90 and level < 120:
		sprite.play("FeedGreen")
	elif level >= 120 and level < 150:
		sprite.play("FeedGrey")
	elif level >= 150 and level < 180:
		sprite.play("Feed")
	else:
		if random_number == 88:
			sprite.play("FeedFire")
		else:
			sprite.play("FeedMetal")


func evolve_pet_play():
	if level < 30:
		sprite.play("PlayBlack")
	elif level >= 30 and level < 60:
		sprite.play("PlayBlue")
	elif level >=60 and level < 90:
		sprite.play("PlayRed")
	elif level >= 90 and level < 120:
		sprite.play("PlayGreen")
	elif level >= 120 and level < 150:
		sprite.play("PlayGrey")
	elif level >= 150 and level < 180:
		sprite.play("Play")
	else:
		if random_number == 88:
			sprite.play("PlayFire")
		else:
			sprite.play("PlayMetal")
		
		
func evolve_pet_clean():
	if level < 30:
		sprite.play("CleanBlack")
	elif level >= 30 and level < 60:
		sprite.play("CleanBlue")
	elif level >= 60 and level < 90:
		sprite.play("CleanRed")
	elif level >= 90 and level < 120:
		sprite.play("CleanGreen")
	elif level >= 120 and level < 150:
		sprite.play("CleanGrey")
	elif level >= 150 and level < 180:
		sprite.play("Clean")
	else:
		if random_number == 88:
			sprite.play("CleanFire")
		else:
			sprite.play("CleanMetal")
	
	
func random_number_generator():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random_number = rng.randi_range(1, 100)
	return random_number
	

func every_game_tick_increase_level():
	level += 0.00000001
	var levelString = "Level: " + str(level) + " #"
	levelLabel.clear()
	levelLabel.set_text(levelString)


func every_game_tick_check_food():
	var foodString = "Food Counter: " + str(food_counter)
	foodLabel.clear()
	foodLabel.set_text(foodString)		


func every_game_tick_check_mood():
	var moodString = "Mood Counter: " + str(mood_counter)
	moodLabel.clear()
	moodLabel.set_text(moodString)	
	

func every_game_tick_check_clean():
	var cleanString = "Clean Counter: " + str(clean_counter)
	cleanLabel.clear()
	cleanLabel.set_text(cleanString)
	

func check_feed_button_reset():
	if clickFeedButtonTime	== null:
		$"Feed button".disabled = false
	else:
		var currentTime = OS.get_unix_time()
		if currentTime - clickFeedButtonTime >= 28800:
			$"Feed button".disabled = false
		else:
			$"Feed button".disabled = true
			
			
func check_play_button_reset():
	if clickPlayButtonTime	== null:
		$"Play button".disabled = false
	else:
		var currentTime = OS.get_unix_time()
		if currentTime - clickPlayButtonTime >= 28800:
			$"Play button".disabled = false
		else:
			$"Play button".disabled = true
			
			
func check_clean_button_reset():
	if clickCleanButtonTime	== null:
		$"Clean button".disabled = false
	else:
		var currentTime = OS.get_unix_time()
		if currentTime - clickCleanButtonTime >= 28800:
			$"Clean button".disabled = false
		else:
			$"Clean button".disabled = true		
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Every game-tick where the player is in the game, 
	# this every_game_tick_increase_level() function will be called
	# which increases the player's level by a minute amount
	every_game_tick_increase_level()
	every_game_tick_check_food() 
	every_game_tick_check_mood()
	every_game_tick_check_clean()
	
	# For feed, play, clean button -> reset every 8 hours
	check_feed_button_reset()
	check_play_button_reset()
	check_clean_button_reset()

	# To setup the Date & Time clocks
	var timeDict = OS.get_datetime()
	var second = str(timeDict.second)
	var minute = str(timeDict.minute)
	var hour = str(timeDict.hour)
	var day = str(timeDict.day)
	var month = str(timeDict.month)
	var year = str(timeDict.year)
	
	if int(second) < 10:
		second = '0' + second
		
	if int(minute) < 10:
		minute = '0' + minute
		
	if int(hour) < 10:
		hour = '0' + hour
	
	if int(day) < 10:
		day = '0' + day
	
	if int(month) < 10:
		month = '0' + month
	
	var dateString = "Date: " + day + '-' + month + '-' + year
	var timeString = hour + ":" + minute + ":" + second
	
	if int(hour) < 12:
		timeString += ' AM'
	else:
		timeString += ' PM'
			
	dateLabel.clear()
	dateLabel.add_text(dateString)
	timeLabel.clear()
	timeLabel.add_text(timeString)
	
	# To setup the Day clock/timer
	var currentDay = OS.get_unix_time()
	var daysDiff = int((currentDay - startDay) / (24 * 60 * 60))
	var dayString = "Day: " + str(daysDiff)
	dayLabel.clear()
	dayLabel.add_text(dayString)


func reset_all_counters(): 
	food_counter = 0
	mood_counter = 0
	clean_counter = 0
	
	foodLabel.clear()
	moodLabel.clear()
	cleanLabel.clear()
	
	foodLabel.set_text("Food Counter: " + str(food_counter))
	moodLabel.set_text("Mood Counter: " + str(mood_counter))
	cleanLabel.set_text("Clean Counter: " + str(clean_counter))
	
	
func _on_Input_text_entered(new_text):
	# Developer cheat codes
	if new_text == 'change_black_slime()':
		level = 0.5
	elif new_text == 'change_blue_slime()':
		level = 30.5
	elif new_text == 'change_red_slime()':
		level = 60.5
	elif new_text == 'change_green_slime()':
		level = 90.5
	elif new_text == 'change_grey_slime()':
		level = 120.5
	elif new_text == 'change_transparent_slime()':
		level = 150.5
	elif new_text == 'change_metal_slime()':
		level = 180.5
		random_number = 1
	elif new_text == 'change_fire_slime()':
		level = 180.5
		random_number = 88
	elif new_text == 'increase_level()':
		level += 30
	elif new_text == 'increase_food()':
		food_counter += 10
		level += 2.5
		feed_increase_level()
		clickFeedButtonTime = null
		$"Feed button".disabled = false
	elif new_text == 'increase_mood()':
		mood_counter += 10
		level += 1.5
		play_increase_level()
		clickPlayButtonTime = null
		$"Play button".disabled = false
	elif new_text == 'increase_clean()':
		clean_counter += 10
		level += 1
		clean_increase_level()
		clickCleanButtonTime = null
		$"Clean button".disabled = false
	elif new_text == 'reset_all()':
		level = 0
		
		reset_all_counters()
		
		clickFeedButtonTime = null
		clickPlayButtonTime = null
		clickCleanButtonTime = null		
	elif new_text == 'reset_buttons()':
		clickFeedButtonTime = null
		clickPlayButtonTime = null
		clickCleanButtonTime = null
	elif new_text == 'check_random_number()':
		$ConfirmationDialog.dialog_text = str(random_number)
		$ConfirmationDialog.popup_centered()
	elif new_text == 'check_unix_timestamp()':
		$ConfirmationDialog.dialog_text = str(startDay)
		$ConfirmationDialog.popup_centered()
	elif new_text == 'check_day()':
		# need to cast both numbers as float to do "real" division in Godot
		# https://www.reddit.com/r/godot/comments/actyfk/godot_how_to_do_real_division_in_gdscript/
		var currentDay = OS.get_unix_time()
		var daysDiff = float((currentDay - startDay)) / float((24 * 60 * 60))
		var dayString = str(daysDiff)
		$ConfirmationDialog.dialog_text = "Day: " + dayString
		$ConfirmationDialog.popup_centered()

	# Normal commands
	elif new_text == 'feed':
		$Player/feedSound.play()
		evolve_pet_feed()
	elif new_text == 'play':
		$Player/playSound.play()
		evolve_pet_play()
	elif new_text == 'clean':
		$Player/cleanSound.play()
		evolve_pet_clean()
	else:
		pass
				
		
func _on_Save_button_pressed():
	save_data()
	$ConfirmationDialog.dialog_text = "Game saved!"
	$ConfirmationDialog.popup_centered()
	$ConfirmationDialog/save.play()
