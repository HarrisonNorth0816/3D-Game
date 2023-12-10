extends Node

var kills = 0 
var score = 0

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	
func _process(_delta):
	if Input.is_action_just_pressed("Pause"):
		var menu = get_node_or_null("/root/Game/UI/Menu")
		if menu == null:
			get_tree().quit()
		else:
			if menu.visible:
				get_tree().paused = false
				menu.hide()
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			else:
				get_tree().paused = true
				menu.show()
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func update_deaths():
	kills += 1
	if kills == 5:
		get_tree().change_scene_to_file("res://Assets/end screen/win.tscn")
		
func update_score(s):
	score += s
	var HUD = get_node_or_null("/root/MazeScene/UI/HUD")
	var finalScore = get_node_or_null("/root/victory/Rain")
	if HUD != null:
		HUD.update_score()
	if finalScore != null:
		finalScore.update_score()
		
func reset():
	get_tree().paused = false
	score = 0
	


