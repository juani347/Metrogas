extends Node2D

var score_plus=100
var score_minus=50
export var score_max=780
signal score_gained(score)
signal score_lost(score)
signal show_scoreplus()
signal show_scoreminus()
signal change_challenge(val)

var score_current=0
var obj_clicked=null
var container=null
var component=null
var colocados= 0
var desafio=1
var totalscore

func _ready():
	$ProgressBar.initiate_max(score_max)
	$consigna1.show()
	score_plus=Main.scoreplus_challenge[0]
	score_minus=Main.scoreminus_challenge[0]
	$Plus.animation=Main.sprite_texture_plus[0]
	$Minus.animation=Main.sprite_texture_minus[0]


func _process(_delta):
	if(obj_clicked && container):
		if (obj_clicked.dragging):   #&& container.get_parent()==component): solo se ilumina el correspondiente
			container.change()
			#emit_signal('obj_in') tambien se podria emitir una señal para cada uno..
			

func _on_Obj_clicked(obj):
	obj_clicked=obj
	component=obj_clicked.get_parent()


func _on_Obj_drop():
	pass

func _on_Contenedor_selected(obj):
	container=obj

func _on_Contenedor_deselected():
	container=null

func _on_Timer_timeout():
	$Plus.hide()
	$Minus.hide()

func _on_change_challenge(val):
	desafio= val
	$Timer_Challenge.start()

func _on_show_scoreplus():
	$Plus.show()
	$AnimationPlus.play("zoom")
	$Timer.start()

func _on_show_scoreminus():
	$Minus.show()
	$AnimationMinus.play("zoom")
	$Timer.start()

func _on_Clock_game_over():
	pass # Replace with function body.

func _on_Timer_Challenge_timeout():
	var val=desafio
	score_plus=Main.scoreplus_challenge[val-1]
	score_minus=Main.scoreminus_challenge[val-1]
	$Plus.animation=Main.sprite_texture_plus[val-1]
	#$Plus.texture=load(Main.sprite_texture_plus[val-1])
	if((val-1) >= 2):
		$Minus.animation="nill"
	else:
		$Minus.animation=Main.sprite_texture_minus[val-1]
