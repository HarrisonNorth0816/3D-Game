extends Node

var kills = 0 


func _ready():
	process_mode = PROCESS_MODE_ALWAYS		# global should never be paused
	

func update_deaths():
	kills += 1
	if kills == 1:
		get_tree().change_scene_to_file("res://Assets/end screen/win.tscn")
	


