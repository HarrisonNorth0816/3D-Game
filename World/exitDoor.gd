extends Area3D

func _on_body_entered(body):
	if body.name == "Player":
		if name == "doorExit":
			var _target = get_tree().change_scene_to_file("res://World/transition.tscn")

