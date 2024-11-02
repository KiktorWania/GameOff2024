extends Sprite3D
class_name ItemSprite

var camera : Camera3D
var originalPos : Transform3D

var newPos : Transform3D
var b = false

func _ready():
	camera = get_viewport().get_camera_3d()
	originalPos = transform

func _physics_process(delta):
	if(b):
		transform = transform.interpolate_with(newPos, 0.2)
	else:
		transform = transform.interpolate_with(originalPos, 0.2)

func hoover():
	newPos = originalPos
	newPos.origin.y += .1
	b = true
	
func lay():
	b = false
