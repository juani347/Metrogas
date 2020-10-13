extends TextureProgress

func _ready():
	value=0

func _on_score_gained(growth_data):
	var aux=value
	value+=growth_data
	animate_value(aux,value)

func _on_score_lost(reduction_data):
	var aux=value
	value-=reduction_data
	animate_value(aux,value)

func animate_value(start,end):
	$Tween.interpolate_property(self, "value", start,end, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()

func initiate_max(val):
	max_value=val
