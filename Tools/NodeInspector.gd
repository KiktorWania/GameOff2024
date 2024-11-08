extends Node

@export var camera : MainCamera
var focusedClickable : Clickable = null
var inspecting = false

var label1 : ClickableLabel = null
var label2 : ClickableLabel = null

func _input(event):
	if(event.is_action_pressed("inspect")):
		
		inspecting = !inspecting
		
func _process(delta):
	var space_state = camera.get_world_3d().direct_space_state
	
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_end = ray_origin + camera.project_ray_normal(mouse_pos) * 2000
	
	var params = PhysicsRayQueryParameters3D.new()
	params.from = ray_origin
	params.to = ray_end
	params.collide_with_areas = true
	
	var intersection = space_state.intersect_ray(params)
	if(!intersection.is_empty()):
		var hit = intersection.get("collider")
		if(hit is Clickable and hit != focusedClickable):
			if(inspecting):
				checkForLabelsOnly(hit)
			else:
				onNewHit(hit)
	else:
		clearFocus()

func checkForLabelsOnly(hit):
	if(hit is ClickableLabel):
		onNewHit(hit)
	
func onNewHit(hit):
	if(focusedClickable != null):
		focusedClickable.on_mouse_exit()
		focusedClickable = hit
		focusedClickable.on_mouse_enter()
	else:
		focusedClickable = hit
		focusedClickable.on_mouse_enter()
func clearFocus():
	if(focusedClickable != null):
		focusedClickable.on_mouse_exit()
		focusedClickable = null
