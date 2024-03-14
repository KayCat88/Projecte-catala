extends CharacterBody3D


const SPEED = -15.0
const JUMP_VELOCITY = 25
@onready var carles = $Carles
@export var head: Node3D
@export var camera: Node3D
@onready var shot_point = $Cap/Camera3D/RayCast3D

@onready var animation_player = $Cap/Camera3D/Carles/AnimationPlayer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var gravity_modifier = 6
const SENSITIVITY = 0.001
const BODY_SENSITIVITY = 1
var anim_time = 0.15

var bullet = load("res://Escenes i Nodos/Nodos petits/bullet.tscn")
var instance 
var reload_time = 1

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		
		head.rotate_y(-event.relative.x * SENSITIVITY)
			
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))


func _physics_process(delta):
	# Add the gravity.
#region New Code Region
	if not is_on_floor():
		velocity.y -= gravity * delta * gravity_modifier

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("esquerra", "dreta", "envant", "enrere")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = 0.0
			velocity.z = 0.0
		
	if  anim_time > 0:
		animation_player.play("Shoot")
		
	else:
		animation_player.play("Idle")
#endregion
		
	
	if Input.is_action_just_pressed("clic"):
		anim_time = 1.3
		if reload_time < 0:
			instance = bullet.instantiate()
			instance.position = shot_point.global_position
			instance.transform.basis = shot_point.global_transform.basis
			get_parent().add_child(instance)
			reload_time = 1.3
		
	anim_time -= delta
	reload_time -= delta
	
	
	

	move_and_slide()
