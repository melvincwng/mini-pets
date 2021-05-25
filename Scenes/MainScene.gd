extends Node2D

onready var dateLabel = $Date
onready var timeLabel = $Time
onready var dayLabel = $Day
onready var startDay = OS.get_unix_time()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
	
	
