extends Node

var kills = 0 
var score = 0

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS# global should never be paused
	
	
func _input(event):
	if event.is_action_pressed("Pause"):
		var menu = get_node_or_null("/root/Game/UI/Menu")
		if menu == null:
			get_tree().quit()
		else:
			if menu.hidden:
				menu.show()
				get_tree().paused = true
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
				print("you can see the menu")
			else:
				menu.hide()
				get_tree().paused = false
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
				print("You cant see the menu")

func update_deaths():
	kills += 1
	if kills == 2:
		get_tree().change_scene_to_file("res://Assets/end screen/win.tscn")
		
func update_score(s):
	score += s
	var HUD = get_node_or_null("/root/MazeScene/UI/HUD")
	var finalScore = get_node_or_null("/root/victory/Rain")
	if HUD != null:
		HUD.update_score()
	if finalScore != null:
		finalScore.update_score()


