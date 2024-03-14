extends StaticBody3D

@export var animation_player: AnimationPlayer
@export var collider: CollisionShape3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func morir():
	animation_player.play("Mort")
	collider.disabled = true
