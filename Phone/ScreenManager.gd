extends Node3D
var active = false


func _ready():
	pass 
	
func _process(delta):
	visible = active

func activate():
	for c in get_children():
		if(c is Interactable):
			c.active = true
