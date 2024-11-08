extends Area3D
class_name Clickable

var focus = false
var wasClicked = false

func _process(delta):	
	if(InputMap.has_action("LMB") and Input.is_action_just_pressed("LMB") and focus):
		on_click()
		
func on_mouse_enter():
	focus = true
	
func on_mouse_exit():
	focus = false
	
func on_click():
	wasClicked = true
