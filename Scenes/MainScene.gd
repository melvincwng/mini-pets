extends Node2D

# need to save these variables
var level = 0
var food_counter = 0
var mood_counter = 0
var clean_counter = 0
#need to be able to save this random_number so that the system can remember if the player has a chance to transform into the rare fire slime
var random_number = random_number_generator() if random_number == null else random_number


onready var dateLabel = $Date
onready var timeLabel = $Time
onready var dayLabel = $Day
onready var levelLabel = $Level
onready var foodLabel = $Food
onready var moodLabel = $Mood
onready var cleanLabel = $Clean
onready var sprite = $Player
onready var timer1 = $Timer
onready var timer2 = $Timer2
onready var timer3 = $Timer3
onready var startDay = OS.get_unix_time() # need to find a way to store this... so the system knows how to calculate the number of days the pet has been growing


# Called when the node enters the scene tree for the first time.
func _ready():
	Signal.connect("feed_pet", self, "feed_increase_level")
	Signal.connect("play_pet", self, "play_increase_level")
	Signal.connect("clean_pet", self, "clean_increase_level")
	sprite.play("IdleBlack")
	#print(random_number)
	
	
# This is similar to useEffect hook in JS
# when line 17 aka the transparent slime "Idle" animation ends
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
	
	# disable the feed button for 12 hours (43200 seconds) after clicking
	timer1.start()
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
	
	# disable the play button for 12 hours after clicking
	timer2.start()
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
	
	#disable the clean button 12 hours after clicking
	timer3.start()
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
			
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Every game-tick where the player is in the game, 
	# this every_game_tick_increase_level() function will be called
	# which increases the player's level by a minute amount
	every_game_tick_increase_level() 
	
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
	var daysDiff = (currentDay - startDay) / (24 * 60 * 60)
	var dayString = "Day: " + str(daysDiff)
	dayLabel.clear()
	dayLabel.add_text(dayString)
	

func _on_Timer_timeout():
	$"Feed button".disabled = false
	

func _on_Timer2_timeout():
	$"Play button".disabled = false


func _on_Timer3_timeout():
	$"Clean button".disabled = false

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
		level = 0.4
	elif new_text == 'change_blue_slime()':
		level = 1.4
	elif new_text == 'change_red_slime()':
		level = 2.4
	elif new_text == 'change_green_slime()':
		level = 3.4
	elif new_text == 'change_grey_slime()':
		level = 4.4
	elif new_text == 'change_transparent_slime()':
		level = 5.4
	elif new_text == 'change_metal_slime()':
		level = 6.4
		random_number = 1
	elif new_text == 'change_fire_slime()':
		level = 6.4
		random_number = 88
	elif new_text == 'increase_level()':
		level += 30
	elif new_text == 'increase_food()':
		food_counter += 10
		feed_increase_level()
		timer1.stop()
		$"Feed button".disabled = false
	elif new_text == 'increase_mood()':
		mood_counter += 10
		play_increase_level()
		timer2.stop()
		$"Play button".disabled = false
	elif new_text == 'increase_clean()':
		clean_counter += 10
		clean_increase_level()
		timer3.stop()
		$"Clean button".disabled = false
	elif new_text == 'reset_all()':
		level = 0
		
		reset_all_counters()
		
		$"Feed button".disabled = false
		$"Play button".disabled = false
		$"Clean button".disabled = false
	elif new_text == 'reset_buttons()':
		$"Feed button".disabled = false
		$"Play button".disabled = false
		$"Clean button".disabled = false
	
		
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
		
		
		
		
	
