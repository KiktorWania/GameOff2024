extends Camera3D

@export var tableNode : Node3D
@export var personNode : Node3D
var lookingAt

var hoveredObject : Interactable = null

func _ready():
	lookingAt = personNode

func _process(delta):
	if(Input.is_action_just_pressed("test")):
		lookingAt = personNode
	elif(Input.is_action_just_pressed("test2")):
		lookingAt = tableNode

func _physics_process(delta):
	transform = transform.interpolate_with(transform.looking_at(lookingAt.global_position), 0.2)
	
	var mouse_pos = get_viewport().get_mouse_position()
	
	var from = project_ray_origin(mouse_pos)
	var to = from + project_ray_normal(mouse_pos) * 5000
	
	var space_state = get_world_3d().direct_space_state
	
	var params = PhysicsRayQueryParameters3D.new()
	params.from = from
	params.to = to
	params.collide_with_areas = true
	
	var result = space_state.intersect_ray(params)
	
	#todo check if new object is different from currentHoveredObject to avoid situation where 2 objects are hovered at the same time
	if(!result.is_empty()):
		hoveredObject = result.get("collider") 
		hoveredObject.hovered = true
	else:
		if(hoveredObject):
			hoveredObject.hovered = false
