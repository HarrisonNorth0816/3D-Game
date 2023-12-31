extends RigidBody3D


@onready var Weapon = load("res://Player/shotgun.tscn")

func _input(event):
	if event.is_action_pressed("Pickup"):
		for b in $Area3D.get_overlapping_bodies():
			if b.has_method("pickup"):
				var weapon = Weapon.instantiate()
				b.pickup(weapon)
				queue_free()
