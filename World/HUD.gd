extends Control

func update_score():
	$Score.text = "Score: " + str(Global.score)
