extends Node2D

var ObjectToFall = preload("res://Object/ObjectToFall.tscn")
var nbr_object_falling 

onready var timer_object_to_show = $TimerObjectToShow


func _ready():
	self.nbr_object_falling = 0
	timer_object_to_show.wait_time = 5


#func _process(delta):
#	pass


func _on_TimerObjectToShow_timeout():
	var object_to_fall = ObjectToFall.instance()
	self.add_child(object_to_fall)
	self.nbr_object_falling += 1
	
	if self.nbr_object_falling < 5:
		timer_object_to_show.wait_time = 3
	elif self.nbr_object_falling < 10:
		timer_object_to_show.wait_time = 2.5
	elif self.nbr_object_falling < 15:
		timer_object_to_show.wait_time = 2
	elif self.nbr_object_falling < 20:
		timer_object_to_show.wait_time = 1.5
	elif self.nbr_object_falling < 25:
		timer_object_to_show.wait_time = 1
	else:
		timer_object_to_show.wait_time = 0.5
