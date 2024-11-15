@tool
extends Label3D

@export var mesh : Sprite3D

func _ready():
	textUpdate()

func _process(delta):
	if Engine.is_editor_hint():
		textUpdate()
		
func textUpdate():
	var nPos = text.find("\n")
	
	print(nPos)
	
	mesh.scale.x = nPos + 1
	mesh.scale.y = text.count("\n") + 1
