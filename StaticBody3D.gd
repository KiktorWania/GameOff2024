extends StaticBody3D
class_name Item

var hoover = false

var original_transform : Transform3D
var camera : Camera3D

@onready var sprite : ItemSprite = $ItemSprite
	
func _physics_process(delta):
	if(hoover):
		sprite.hoover()
	else:
		sprite.lay()
