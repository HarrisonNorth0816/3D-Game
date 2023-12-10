extends Area3D


@onready var player = load("res://Assets/demons/player.tscn")

func _on_body_entered(body):
	if body.name == "Player":
		get_node("/../../../%Shotgun").visible()
		queue_free()
