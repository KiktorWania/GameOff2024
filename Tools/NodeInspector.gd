extends Node

@export var camera : MainCamera
@onready var UI : CustomControl = $"../Ui"
var focusedClickable : Clickable = null
var inspecting = false

var labels : Array[ClickableLabel] = [null, null]

func _input(event):
	if(event.is_action_pressed("inspect")):
		inspecting = !inspecting
		if(!inspecting):
			labels[0] = null
			labels[1] = null
		
func _process(delta):
	updateFocusedClickable()
	inspection()
	
	if(inspecting):
		get_tree().call_group("clickableLabels", "activate")
	else:
		get_tree().call_group("clickableLabels", "deactivate")
	
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
			onNewHit(hit)
	else:
		clearFocus()

func inspection():
	if(inspecting):
		var canDraw = true
		for l in labels:
			if(l):
				l.on_inspect()
			else:
				canDraw = false
		UI.setCanDraw(canDraw)
		if canDraw:
			UI.setPositions(camera.unproject_position(labels[0].global_position), camera.unproject_position(labels[1].global_position))
			checkLabelsData(labels[0], labels[1])
	else:
		UI.setCanDraw(false)

func checkLabelsData(l1 : ClickableLabel, l2 : ClickableLabel):
	if(l1.label.text == l2.label.text):
		UI.areNodesConnected(true)
	else:
		UI.areNodesConnected(false)

func checkForLabelsOnly(hit):
	onNewHit(hit)
	if(hit is ClickableLabel and hit.wasClicked):
		add_label(hit)

func add_label(new_value):
	if new_value in labels:
		return
	
	if labels[0]:
		labels[0].label.modulate = Color(1,1,1,1)
		labels[0].wasClicked = false
		
	labels[0] = labels[1]
	labels[1] = new_value
	
func onNewHit(hit):
	if inspecting:
		if hit is ClickableLabel:
			pass
		else:
			return

	if(focusedClickable != null):
		focusedClickable.on_mouse_exit()
		focusedClickable = hit
		focusedClickable.on_mouse_enter()
	else:
		focusedClickable = hit
		focusedClickable.on_mouse_enter()

func updateFocusedClickable():
	if(focusedClickable is ClickableLabel):
		if(focusedClickable.wasClicked and inspecting):
			add_label(focusedClickable)

func clearFocus():
	if(focusedClickable != null):
		focusedClickable.on_mouse_exit()
		focusedClickable = null
