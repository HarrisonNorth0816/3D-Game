extends Node

var kills = 0 

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS		# global should never be paused
	
	
func _input(event):
	if event.is_action_pressed("Pause"):
		var menu = get_node("/root/Game/UI/Menu")
		if menu == null:
			get_tree().quit()
		else:
			if menu.hidden:
				print("you can see the menu")
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
				get_tree().paused = true
				menu.show()
			else:
				print("You cant see the menu")
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
				get_tree().paused = false
				menu.hide()

func update_deaths():
	kills += 1
	if kills == 1:
		get_tree().change_scene_to_file("res://Assets/end screen/win.tscn")
	


