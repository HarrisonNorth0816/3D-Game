extends CharacterBody3D


var speed
const WALK_SPEED = 5.0
const SPRINT_SPEED = 8.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.003


const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var t_bob = 0.0

const BASE_FOV = 90.0
const FOV_CHANGE = 1.5

const balloon = preload("res://text/balloon.tscn")
var played = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 9.8

var bullet = load("res://Player/bullet.tscn")
var instance

@onready var head = $Pivot
@onready var camera = $Pivot/Camera3D
@onready var gun_anim = $Pivot/Camera3D/Shotgun/Shoot
@onready var gun_barrel = $Pivot/Camera3D/Shotgun/RayCast3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))
	if event.is_action_pressed("talk") and played != true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		var textBalloon = balloon.instantiate()
		get_tree().current_scene.add_child(textBalloon)
		textBalloon.start(load("res://text/conversation.dialogue"), "main")
		played = true
		

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 5.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 5.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 2.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 2.0)
		
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	
	var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	
	if Input.is_action_pressed("shoot"):
		if !gun_anim.is_playing():
			$Shoot.play()
			gun_anim.play("Shoot")
			$Rack.play()
			instance = bullet.instantiate()
			instance.position = gun_barrel.global_position
			instance.transform.basis = gun_barrel.global_transform.basis
			get_parent().add_child(instance)
			
	move_and_slide()

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ) * BOB_AMP
	return pos

func pickup(weapon):
	$Pivot/Camera3D/Shotgun.add_child(weapon)


func die():
	get_tree().change_scene_to_file("res://Assets/end screen/death.tscn")
