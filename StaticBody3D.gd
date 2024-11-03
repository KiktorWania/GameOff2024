extends Interactable

var picked = false

var original_transform : Transform3D
@export var camera : Camera3D

@onready var sprite : ItemSprite = $ItemSprite
@onready var screen = $ItemSprite/Screen
@export var snapPoint : Node3D

signal on_pick

func _ready():
	original_transform = transform
	screen.active = picked 

func _process(delta):
	if(Input.is_action_just_pressed("LMB") and !picked):
		picked = true
		sprite.hovered = false
		screen.active = true
		screen.activate()
	if(Input.is_action_just_pressed("PutDown") and picked):
		picked = false
		screen.active = false

func _physics_process(delta):
	if(picked):
		transform = transform.interpolate_with(snapPoint.global_transform, 0.2)
	if(!picked):
		transform = transform.interpolate_with(original_transform, 0.2)
		sprite.hovered = hovered
