extends Node3D

const SPEED = 40.0

@onready var mesh = $MeshInstance3D
@onready var particles = $GPUParticles3D

func _ready():
	pass
	
	
func _process(delta):
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
		
	
	


func _on_timer_timeout():
	queue_free()


func _on_body_entered(body):
	mesh.visible = false
	particles.emitting = true
	if body.is_in_group("enemy"):
		body.hit(5)
	await get_tree().create_timer(1.0).timeout
	queue_free()
