extends Camera3D

@export var tableNode : Node3D
@export var personNode : Node3D
var lookingAt

var focusedClickable : Clickable = null

func _ready():
	lookingAt = personNode

func _process(delta):
	if(Input.is_action_just_pressed("test")):
		lookingAt = personNode
	elif(Input.is_action_just_pressed("test2")):
		lookingAt = tableNode

func _physics_process(delta):
	transform = transform.interpolate_with(transform.looking_at(lookingAt.global_position), 0.2)
	
	var space_state = get_world_3d().direct_space_state
	
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = project_ray_origin(mouse_pos)
	var ray_end = ray_origin + project_ray_normal(mouse_pos) * 2000
	
	var params = PhysicsRayQueryParameters3D.new()
	params.from = ray_origin
	params.to = ray_end
	params.collide_with_areas = true
	
	var intersection = space_state.intersect_ray(params)
	if(!intersection.is_empty()):
		var clicked = intersection.get("collider")
		if(clicked is Clickable and clicked != focusedClickable):
			if(focusedClickable != null):
				focusedClickable.on_mouse_exit()
			focusedClickable = clicked
			focusedClickable.on_mouse_enter()
	else:
		clearFocus()
			
func clearFocus():
	if(focusedClickable != null):
		focusedClickable.on_mouse_exit()
		focusedClickable = null
