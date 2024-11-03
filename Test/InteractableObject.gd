@tool
extends Area3D
class_name Interactable

var hovered = false
@export var active = true

@export var collisionShape : CollisionShape3D

func _ready():
	collisionShape.disabled = !active

func _process(delta):
	collisionShape.disabled = !active
	
	if(hovered):
		print("skibidi")
