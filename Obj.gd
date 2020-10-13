extends Sprite


var mousepos
#var mouse_in = false
var dragging = false
var locked= false
export var start_position= Vector2(0,0)
export var final_position= Vector2(0,0)
export var collision_scale= Vector2(1,1)
export var final_scale= Vector2(1,1)
export var desafio= 0
signal change_drag(cond)
signal clicked
signal drop


func _ready():
	position= start_position
	$Area2D/CollisionShape2D.scale= collision_scale


func _process(_delta):
	if dragging:
		mousepos = get_viewport().get_mouse_position()
		self.position = Vector2(mousepos.x, mousepos.y)


func _on_Area2D_mouse_entered():
#	mouse_in = true
	if (!locked):
		modulate= Color(1, 1, 1)

func _on_Area2D_mouse_exited():
#	mouse_in = false
	if (!locked):
		modulate= Color(1, 1, 1, 0.705882)
		
func lock(pos):
	position= pos
	locked= true
	scale= final_scale


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if (!locked):
		if (event is InputEventMouseButton):
			if (event.button_index == BUTTON_LEFT and event.pressed):
				emit_signal("change_drag",true)
				emit_signal("clicked",self)
				z_index=2
			elif (dragging and event.button_index == BUTTON_LEFT and !event.pressed):
				emit_signal("change_drag",false)
		elif (event is InputEventScreenTouch):
			if (event.pressed and event.get_index() == 0):
				self.position = event.get_position()


func _on_Node2D_change_drag(cond):
	#dragging=!dragging
	dragging= cond
	if (dragging==false):
		emit_signal("drop")
		z_index=1


func _on_Obj_change_drag(cond):
	dragging= cond
	if (dragging==false):
		emit_signal("drop")
		z_index=1
