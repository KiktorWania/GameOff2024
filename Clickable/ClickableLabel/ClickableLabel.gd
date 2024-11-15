@tool
extends Clickable
class_name ClickableLabel

@onready var label : Label3D = $Label3D
@onready var shape : CollisionShape3D = $CollisionShape3D
@export var isBad : bool
@export var badMask : int

@export var text : String

func _ready():
	add_to_group("clickableLabels")
	label.text = text

func _process(delta):
	super(delta)
	if Engine.is_editor_hint():
		if text:
			label.text = text
		else:
			label.text = ""

func activate():
	shape.disabled = false
	
func deactivate():
	shape.disabled = true
	wasClicked = false
	label.modulate = Color(1,1,1,1)
	
func on_inspect():
	label.modulate = Color(1,0,0,1)
