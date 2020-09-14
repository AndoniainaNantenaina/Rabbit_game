extends CanvasLayer

var time_left = 30

func _ready():
	pass

func _physics_process(delta):
	$TimeLeft.text = str(self.time_left)


func _on_TimerTimeLeft_timeout():
	self.time_left -= 1
	if self.time_left == 0:
		get_tree().change_scene("res://GUI/GameOverScreen.tscn")
