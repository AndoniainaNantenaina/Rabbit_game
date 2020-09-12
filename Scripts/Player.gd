extends KinematicBody2D

enum  {
	WALK,
}

var velocity = Vector2.ZERO

export var WALK_SPEED = 120
export var RUN_SPEED = 180
export var FRICTION = 500
export var ACCELERATION = 500
export var GRAVITY = 25
export var JUMP_HIGH = 500

onready var anim_tree = $AnimationTree
onready var anim_state = anim_tree.get("parameters/playback")

onready var state = WALK

func _ready():
	anim_tree.active = true
	
func _physics_process(delta):
	match state:
		WALK :
			walk_state(delta)
	
func move():
	velocity = move_and_slide(velocity, Vector2(0, -1))
		
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

func jump_finished():
	state = WALK
