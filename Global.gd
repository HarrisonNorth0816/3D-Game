extends Node

func _ready():
	process_mode = PROCESS_MODE_ALWAYS		# global should never be paused

func _unhandled_input(event):
	if event.is_action_pressed("Menu"):
		var menu = get_node("/root/Game/World/Menu")
		if menu == null:
			get_tree().quit()
		else:
			if menu.visible:
				get_tree().paused = false 	# pause the game while the menu is visible
				menu.show()
			else:
				get_tree().paused = true
				menu.show()
				
