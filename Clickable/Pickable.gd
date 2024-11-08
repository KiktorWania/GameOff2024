extends Clickable
class_name Pickable

var picked : bool = false
var original_transform : Transform3D

var dragDst
var dir : Vector3
var dragging
var newPos : Vector3
var dragged = false

@export var mesh : test

@export var snapPoint : Node3D

@export var shape : CollisionShape3D
@export var dragableArea : Clickable

func _ready():
	original_transform = transform
	lookForMissingShape()
	
func _process(delta):
	super(delta)
	if(Input.is_action_just_pressed("PutDown") and picked):
		picked = false
		shape.disabled = false

func _physics_process(delta):
	if picked:
		while_picked()
	else:
		while_not_picked()

func on_mouse_enter():
	super()
	
	mesh.hovered = true
func on_mouse_exit():
	super()
	
	mesh.hovered = false

func on_click():
	if(!picked):
		picked = true
		shape.disabled = true
		
func while_picked():
	if(dragging):
		dragged = true
		dragableArea.scale = Vector3(10, 3, 10)
		var newTrans = transform
		newTrans.origin = newPos
		transform = transform.interpolate_with(newTrans, 0.2)
	elif !dragged:
		transform = transform.interpolate_with(snapPoint.global_transform, 0.2)
	else:
		dragableArea.scale = Vector3(1, 1, 1)

func while_not_picked():
	dragged = false
	transform = transform.interpolate_with(original_transform, 0.2)
	
func _input(event):
	var mouse = get_viewport().get_mouse_position()
	var m = Vector3(mouse.x, mouse.y, position.z)
	
	var space_state = get_world_3d().direct_space_state
	
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = get_viewport().get_camera_3d().project_ray_origin(mouse)
	var ray_end = ray_origin + get_viewport().get_camera_3d().project_ray_normal(mouse) * 2000
	
	var params = PhysicsRayQueryParameters3D.new()
	params.from = ray_origin
	params.to = ray_end
	params.collide_with_areas = true
	
	var intersection = space_state.intersect_ray(params)
	if(!intersection.is_empty()):
		var pos = intersection.get("position")
		m = Vector3(pos.x, pos.y, position.z)
	
	if(event is InputEventMouseButton and dragableArea and dragableArea.focus):
		if event.is_pressed():
			dragDst = position.distance_to(m)
			dir = (m - position).normalized()
			dragging = true
			newPos = m - dragDst * dir
		else:
			dragging = false
	elif (event is InputEventMouseMotion):
		if dragging:
			if(!Input.is_action_pressed("LMB")):
				dragging = false
			newPos = m - dragDst * dir
	
func lookForMissingShape():
	if shape == null:
		for c in get_children():
			if c is CollisionShape3D:
				shape = c
				break
