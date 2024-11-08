extends Control
class_name CustomControl

var pos1 : Vector2
var pos2 : Vector2
var canDraw = false

var Label1 : ClickableLabel

func _draw():
	drawThreePointLine()
	
func setPositions(npos1, npos2):
	pos1 = npos1
	pos2 = npos2
	queue_redraw()

func setCanDraw(can):
	canDraw = can
	queue_redraw()
	
func getMiddlePoint(pos1, pos2):
	return Vector2(pos1.x, pos2.y)
	
func setClickableLabel(label : ClickableLabel):
	Label1 = label
	
func drawThreePointLine():
	if(pos1 and pos2 and canDraw):
		var pos3 = getMiddlePoint(pos1, pos2)
		draw_line(pos1, pos3, Color.ALICE_BLUE, 3, true)
		draw_line(pos3, pos2, Color.ALICE_BLUE, 3, true)

func drawOutline(label : ClickableLabel):
	pass
	

