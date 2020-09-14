extends KinematicBody2D

var speed = 200
var velocity = Vector2.ZERO

var HitEffect = preload("res://Effects/HitEffect.tscn")

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
	self.velocity = Vector2(0, getSpeed())

func getSpeed():
	return self.speed
	
func setSpeed(speed):
	self.speed = speed

func _on_HurtBox_area_entered(area):
	var hitEffect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(hitEffect)
	hitEffect.global_position = $Sprite.global_position
	hitEffect.scale.x = 2
	hitEffect.scale.y = 2
	queue_free()
