extends Node2D

var level = 0 # need to save this variable

onready var dateLabel = $Date
onready var timeLabel = $Time
onready var dayLabel = $Day
onready var levelLabel = $Level
onready var startDay = OS.get_unix_time() # need to find a way to store this... so the system knows how to calculate the number of days the pet has been growing

# Called when the node enters the scene tree for the first time.
func _ready():
	Signal.connect("feed_pet", self, "feed_increase_level")
	Signal.connect("play_pet", self, "play_increase_level")
	Signal.connect("clean_pet", self, "clean_increase_level")

func feed_increase_level():
	level += 0.25
	var levelString = "Level: " + str(level)
	levelLabel.clear()
	levelLabel.set_text(levelString)
	
func play_increase_level():
	level += 0.15
	var levelString = "Level: " + str(level)
	levelLabel.clear()
	levelLabel.set_text(levelString)
	
func clean_increase_level():
	level += 0.1
	var levelString = "Level: " + str(level)
	levelLabel.clear()
	levelLabel.set_text(levelString)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
	
	
