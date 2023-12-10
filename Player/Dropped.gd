extends RigidBody3D


@onready var Weapon = load("res://Player/shotgun.tscn")

func _on_area_3d_body_entered(body):
	for b in $Area3D.get_overlapping_bodies():
		var weapon = Weapon.instantiate()
		b.pickup(weapon)
		queue_free()
