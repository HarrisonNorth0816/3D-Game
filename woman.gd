extends Node3D

func _on_area_3d_body_entered(body):
	$Read.show()
	$lines.play()
	$Read/Control/Label.text = "A hole opened into the catacombs, they are shifting around constantly,
	there was some kind of demon ritual down there.
	Father Garcia was lost down there!
	Use that shotgun of yours to help us Father!"
	$Timer.start()
	

func _on_timer_timeout():
	$Read.hide()
