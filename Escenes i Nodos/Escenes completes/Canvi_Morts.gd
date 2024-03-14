extends Area3D
var n_cossos = 0
@export var canviador: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if n_cossos == 2:
		canviador.Canviar()


func _on_body_entered(body):
	n_cossos += 1
