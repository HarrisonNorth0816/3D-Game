extends ColorRect

func update_score():
	$Score.text = "Final Score: " + str(Global.score)
