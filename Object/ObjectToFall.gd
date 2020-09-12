extends KinematicBody2D

var speed = 200
var velocity = Vector2.ZERO

func _ready():
	randomize()
	self.create(Vector2(rand_range(32, 992), -64))

#func _process(delta):
#	pass

func _physics_process(delta):
	var collision = move_and_collide(self.velocity * delta)
	if collision:
		self.queue_free()

func create(position):
	self.position = position
	self.velocity = Vector2(0, speed)
