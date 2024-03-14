extends Node3D
@onready var malek_animation_player = $ModelMalek/AnimationPlayer
@onready var said_animation_player = $"ModelSaïd/AnimationPlayer"
@onready var camera_3d = $Camera3D
@onready var cam_pos_1 = $CamPos1
@onready var cam_pos_2 = $CamPos2
var accio_1_feta = false

@export var canviador : Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	primera_accio()
	
	if accio_1_feta == true:
		await get_tree().create_timer(1.0).timeout
		camera_3d.position = cam_pos_2.position
		camera_3d.rotation_degrees.x = cam_pos_2.rotation_degrees.x
		segona_accio()
	
	
func primera_accio():
	if Input.is_action_just_pressed("clic") and accio_1_feta == false:
		malek_animation_player.play("Atac 1")
		said_animation_player.play("Caiguda")
		accio_1_feta = true

func segona_accio():
	if Input.is_action_just_pressed("clic") and accio_1_feta == true:
		malek_animation_player.play("Atac 2 aturat")
		said_animation_player.play("Aturada")
		
