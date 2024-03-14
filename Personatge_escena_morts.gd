extends CharacterBody3D


const SPEED = 15.0
const JUMP_VELOCITY = 25

@export var head: Node3D
@export var camera: Node3D
@export var positioner: Node3D


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var gravity_modifier = 6
const SENSITIVITY = 0.001
const BODY_SENSITIVITY = 1
var anim_time = 0.15
var offset : Vector3

var agafat: bool
var cos_mort


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		
		head.rotate_y(-event.relative.x * SENSITIVITY)
			
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(90))
		


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
		
	
#endregion
		
	if Input.is_action_just_pressed("clic") and agafat == true and cos_mort != null:
			agafat = false
			cos_mort.Caure()
			camera.remove_child(cos_mort)
			get_parent().add_child(cos_mort)
			cos_mort = null
			
	if Input.is_action_just_pressed("clic") and agafat == false and cos_mort != null:
			agafat = true
	if agafat == true:
		cos_mort.get_parent().remove_child(cos_mort)
		camera.add_child(cos_mort)
		cos_mort.position = positioner.position
		cos_mort.No_caure()
		
		
	
	
	
	
	
	

	move_and_slide()


func _on_area_3d_body_entered(body):
	print("objecte trobat")
	if body.is_in_group("cossos"):
		print("cos trobat")
		cos_mort = body
		
			
			
