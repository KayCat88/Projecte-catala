extends CharacterBody3D


var caure = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() and caure:
		velocity.y -= gravity * delta
		

	

	move_and_slide()
func Caure():
	caure = true
	position.z += 1

func No_caure():
	caure = false
