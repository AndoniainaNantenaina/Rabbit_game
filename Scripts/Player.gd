extends KinematicBody2D

enum  {
	WALK,
}

var health = 3

var velocity = Vector2.ZERO

export var WALK_SPEED = 120 * 1.5
export var RUN_SPEED = 220 * 1.5
export var FRICTION = 500
export var ACCELERATION = 500
export var GRAVITY = 25
export var JUMP_HIGH = 500


onready var anim_tree = $AnimationTree
onready var hitbox = $Hitbox
onready var anim_state = anim_tree.get("parameters/playback")

onready var state = WALK

onready var heartOne = get_tree().current_scene.get_node("HUD/Heart1")
onready var heartTwo = get_tree().current_scene.get_node("HUD/Heart2")
onready var heartThree = get_tree().current_scene.get_node("HUD/Heart3")

func _ready():
	anim_tree.active = true
	
func _physics_process(delta):
	match state:
		WALK :
			walk_state(delta)
		
func walk_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if input_vector != Vector2.ZERO :
		anim_tree.set("parameters/Idle/blend_position", input_vector.x)
		anim_tree.set("parameters/Walk/blend_position", input_vector.x)
		anim_tree.set("parameters/Run/blend_position", input_vector.x)
		anim_tree.set("parameters/Jump/blend_position", input_vector.x)
			
		if Input.is_action_pressed("run") :
			velocity = velocity.move_toward(input_vector * RUN_SPEED, ACCELERATION * delta)
			if Input.is_action_just_pressed("ui_accept") and is_on_floor():
				velocity.y = -JUMP_HIGH
				anim_state.travel("Jump") 
				move_and_slide(input_vector * RUN_SPEED)
			if is_on_floor():
				anim_state.travel("Run")
		else :
			velocity = velocity.move_toward(input_vector * WALK_SPEED, ACCELERATION * delta)
			if is_on_floor():
				anim_state.travel("Walk")
	elif input_vector == Vector2.ZERO :
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		if is_on_floor():
			anim_state.travel("Idle")
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = -JUMP_HIGH
		anim_state.travel("Jump") 
		move()
			
	velocity.y += GRAVITY
	move()
	
func move():
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
func jump_finished():
	state = WALK


func _on_HurtBox_area_entered(area):
#	hitbox.score = hitbox.score - 1
	if self.health == 3:
		self.heartThree.value = 0
		self.health -= 1
	elif self.health == 2:
		self.heartTwo.value = 0
		self.health -= 1
	elif self.health == 1:
		self.heartOne.value = 0
		self.health -= 1
		get_tree().change_scene("res://GUI/GameOverScreen.tscn")

	position = Vector2(100, 500)
