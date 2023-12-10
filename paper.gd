extends Sprite3D


func _on_area_3d_body_entered(body):
	$Read.show()
	$Read/Control/Label.text = "Father John, please come to Jamescreek Bay Church, there has been an 'event', please bring a weapon. Help."
	$Timer.start()

func _on_timer_timeout():
	$Read.hide()
