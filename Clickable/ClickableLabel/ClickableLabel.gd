extends Clickable
class_name ClickableLabel

@onready var label : Label3D = $Label3D
@onready var shape : CollisionShape3D = $CollisionShape3D
@export var isBad : bool
@export var badMask : int

func _ready():
	add_to_group("clickableLabels")

func activate():
	shape.disabled = false
	
func deactivate():
	shape.disabled = true
	wasClicked = false
	label.modulate = Color(1,1,1,1)
	
func on_inspect():
	label.modulate = Color(1,0,0,1)
