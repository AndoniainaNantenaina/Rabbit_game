extends Control


func _ready():
	$AnimationPlayer.play("default")


func _on_ReplayButton_pressed():
	get_tree().change_scene("res://Main.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()