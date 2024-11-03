extends Sprite3D
class_name ItemSprite

var camera : Camera3D
var originalPos : Transform3D

var hoveredPos : Transform3D
var hovered = false

func _ready():
	camera = get_viewport().get_camera_3d()
	originalPos = transform
	hoveredPos = originalPos
	hoveredPos.origin.y += .1

func _physics_process(delta):
	if(hovered):
		transform = transform.interpolate_with(hoveredPos, 0.2)
	else:
		transform = transform.interpolate_with(originalPos, 0.2)
