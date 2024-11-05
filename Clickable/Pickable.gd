extends Clickable
class_name Pickable

var picked : bool = false
var original_transform : Transform3D

@export var snapPoint : Node3D

@export var shape : CollisionShape3D
@export var mainSprite : Sprite3D

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
	
	mainSprite.hovered = true
func on_mouse_exit():
	super()
	
	mainSprite.hovered = false

func on_click():
	if(!picked):
		picked = true
		shape.disabled = true
		
		mainSprite.hovered = false
		
func while_picked():
	transform = transform.interpolate_with(snapPoint.global_transform, 0.2)
func while_not_picked():
	transform = transform.interpolate_with(original_transform, 0.2)
func lookForMissingShape():
	if shape == null:
		for c in get_children():
			if c is CollisionShape3D:
				shape = c
				break
