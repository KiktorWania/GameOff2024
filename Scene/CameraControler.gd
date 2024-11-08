extends Camera3D
class_name MainCamera

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
