extends CharacterBody3D

@onready
var head = $Head
@onready
var camera = $Head/Camera3D
@onready
var raycast = $Head/Camera3D/RayCast3D
@onready
var block_outline = $BlockOutline

var camera_x_rotation = 0

const mouse_sensitivity = 0.3
const movement_speed = 10
const gravity = 20
const jump_velocity = 15

var paused = false

signal place_block(pos, t)
signal break_block(pos)

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if Input.is_action_just_pressed("Pause"):
		paused = not paused
		if paused:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			
	if paused:
		return
		
	if event is InputEventMouseMotion:
		head.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		camera.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))

		#var delta_x = event.relative.y * mouse_sensitivity
		#if camera_x_rotation * delta_x > -90 and camera_x_rotation * delta_x < 90:
		#	camera.rotate_x(deg_to_rad(-delta_x))
		#	camera_x_rotation += delta_x
			
func _physics_process(delta):
	if paused:
		return
		
	var b = head.global_transform.basis
	var direction = Vector3()
	
	if Input.is_action_pressed("Forward"):
		direction -= b.z
	if Input.is_action_pressed("Backward"):
		direction += b.z
	if Input.is_action_pressed("Left"):
		direction -= b.x
	if Input.is_action_pressed("Right"):
		direction += b.x
	
	velocity.z = direction.z * movement_speed
	velocity.x = direction.x * movement_speed
	
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_velocity
		
	velocity.y -= gravity * delta

	move_and_slide()

	if raycast.is_colliding():
		var norm = raycast.get_collision_normal()
		var pos = raycast.get_collision_point() - norm * 0.5
		
		var bx = floor(pos.x) + 0.5
		var by = floor(pos.y) + 0.5
		var bz = floor(pos.z) + 0.5
		var bpos = Vector3(bx, by, bz) - position
		block_outline.position = bpos
		block_outline.visible = true
		
		if Input.is_action_just_pressed("Break"):
			emit_signal("break_block", pos)
		if Input.is_action_just_pressed("Place"):
			emit_signal("place_block", pos + norm, Global.STONE)
			
	else:
		block_outline.visible = false























