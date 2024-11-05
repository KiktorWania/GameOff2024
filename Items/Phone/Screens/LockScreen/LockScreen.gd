extends Node3D

@onready var password = $password
@onready var passwordAnimation = $password/AnimationPlayer

@export var blankIcon : Texture
@export var fullIcon : Texture

var playAnimation = false

var passLen = 0
var code = "1111"
var tempCode = ""

func _ready():
	for c in get_children():
		if(c.has_signal("send_data")):
			c.send_data.connect(on_button_pressed)

func _process(delta):
	pass

func on_button_pressed(data):
	if !passwordAnimation.is_playing():
		tempCode = tempCode + data
		password.get_child(passLen).texture = fullIcon
		passLen += 1
		if(passLen >= 4):
			check_pass()
			passLen = 0

func check_pass():
	if(tempCode == code):
		print("succes")
	else:
		print("failure")
		tempCode = ""
		passLen = 0
		passwordAnimation.play("denied")
