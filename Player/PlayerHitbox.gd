extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var score = 0 setget score_change
onready var scoreLabel = get_tree().current_scene.get_node("HUD/Score")
onready var hud = get_tree().current_scene.get_node("HUD")

func score_change(value):
	score = value
	scoreLabel.text = str(score)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Hitbox_area_entered(area):
	score += 1
	scoreLabel.text = str(score)
	GlobalScore.score = score
	
	hud.time_left += 2
