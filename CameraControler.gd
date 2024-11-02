extends Camera3D

@export var tableNode : Node3D
@export var personNode : Node3D
var lookAt

@onready var raycast : RayCast3D = $RayCast3D
var hooveredObject : Item = null

func _ready():
	lookAt = personNode

func _process(delta):
	if(Input.is_action_just_pressed("test")):
		lookAt = personNode
	elif(Input.is_action_just_pressed("test2")):
		lookAt = tableNode

func _physics_process(delta):
	transform = transform.interpolate_with(transform.looking_at(lookAt.global_position), 0.2)
	
	var mouse_pos = get_viewport().get_mouse_position()
	
	var from = project_ray_origin(mouse_pos)
	var to = from + project_ray_normal(mouse_pos) * 5000
	
	var space_state = get_world_3d().direct_space_state
	
	var params = PhysicsRayQueryParameters3D.new()
	params.from = from
	params.to = to
	
	var result = space_state.intersect_ray(params)
	if(!result.is_empty()):
		hooveredObject = result.get("collider") 
		hooveredObject.hoover = true
	else:
		if(hooveredObject):
			hooveredObject.hoover = false


func lookAtTable():
	look_at(tableNode.global_position)
	
func lookAtPerson():
	look_at(personNode.global_position)
