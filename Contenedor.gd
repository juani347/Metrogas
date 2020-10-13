extends Sprite

var mouse_in= false
export var collision_scale= Vector2(1,1)
var locked=false
#var inside=false
signal selected
signal deselected


# Called when the node enters the scene tree for the first time.
func _ready():
	modulate= Color(0.811765, 0.811765, 0.811765)
	$Area2D/CollisionShape2D.scale= collision_scale

	
func _on_Contenedor_mouse_entered():
	if (!locked):
		emit_signal("selected",self)
		mouse_in=true


func _on_Contenedor_mouse_exited():
	mouse_in=false
	modulate= Color(0.811765, 0.811765, 0.811765)
#	inside=false
	emit_signal("deselected")

func change():
	modulate= Color(0.47451, 0.47451, 0.47451)
#	inside= true

func lock():
	locked=true
	hide()
