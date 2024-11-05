extends Sprite3D
class_name ItemSprite

#todo get rid off this shit

var originalPos : Transform3D

var hoveredPos : Transform3D
var hovered = false

func _ready():
	originalPos = transform
	hoveredPos = originalPos
	hoveredPos.origin.y += .1

func _physics_process(delta):
	if(hovered):
		transform = transform.interpolate_with(hoveredPos, 0.2)
	else:
		transform = transform.interpolate_with(originalPos, 0.2)
