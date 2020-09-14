extends Node2D

var ObjectToFall = preload("res://Object/ObjectToFall.tscn")
var nbr_object_falling
var day_and_night = 1
var speed = 200

onready var timer_object_to_show = $TimerObjectToShow


func _ready():
	self.nbr_object_falling = 0
	timer_object_to_show.wait_time = 5


#func _process(delta):
#	pass


func _on_TimerObjectToShow_timeout():
	var object_to_fall = ObjectToFall.instance()
	object_to_fall.setSpeed(speed)
	self.add_child(object_to_fall)
	self.nbr_object_falling += 1
	
	if self.nbr_object_falling < 5:
		timer_object_to_show.wait_time = 3
	elif self.nbr_object_falling < 10:
		timer_object_to_show.wait_time = 2.5
	elif self.nbr_object_falling < 15:
		timer_object_to_show.wait_time = 2
	elif self.nbr_object_falling < 20:
		self.speed = 250
	elif self.nbr_object_falling < 25:
		timer_object_to_show.wait_time = 1.5
		self.speed = 300
	elif self.nbr_object_falling < 30:
		self.speed = 350
	elif self.nbr_object_falling < 40:
		timer_object_to_show.wait_time = 1
		self.speed += 400
	elif self.nbr_object_falling < 50:
		self.speed += 500


func _on_TimerDayAndNight_timeout():
	if self.day_and_night == 1:
		$Map/AnimationPlayer.play("DayToNight")
		$HUD/AnimationPlayer.play("DayToNight")
		self.day_and_night = 0
	else:
		$Map/AnimationPlayer.play("NightToDay")
		$HUD/AnimationPlayer.play("NightToDay")
		self.day_and_night = 1
