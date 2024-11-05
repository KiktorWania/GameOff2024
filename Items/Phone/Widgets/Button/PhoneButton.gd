@tool
extends Clickable
class_name PhoneButton

@export var customTexture : Texture
@export var customShape : Shape3D

@export var customValue : String = "default"

@onready var sprite = $Sprite3D
@onready var shape = $CollisionShape3D

signal send_data(value)

func _ready():
	checkCustom()

func _process(delta):
	super(delta)
	if Engine.is_editor_hint():
		checkCustom()

func checkCustom():
	if(customTexture):
		sprite.texture = customTexture
	if(customShape):
		shape.shape = customShape
		
func on_click():
	emit_signal("send_data", customValue)
