extends Node3D

@export var animation_player: AnimationPlayer
@export var canviador : Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("clic"):
		animation_player.play("Clavada")
		await get_tree().create_timer(1.5).timeout
		canviador.Canviar()
		
