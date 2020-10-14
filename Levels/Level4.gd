extends Node2D

var score_plus
var score_minus
export var score_max=570
signal score_gained(score)
signal score_lost(score)
signal show_scoreplus()
signal show_scoreminus()
signal change_challenge(val)
signal show_tip(tip)
signal stop_timer()
signal start_timer()

var score_current=0
var obj_clicked=null
var container=null
var component=null
var colocados= 0
var desafio=1
var pop
var fin=false

func _ready():
	$ProgressBar.initiate_max(score_max)
	$consigna1.show()
	$AnimationChallenge.play("Change1")
	score_plus=Main.scoreplus_challenge[0]
	score_minus=Main.scoreminus_challenge[0]
	$Plus.animation=Main.sprite_texture_plus[0]
	$Minus.animation=Main.sprite_texture_minus[0]
	$llama/s_llama.hide()
	pop=get_node("Popup")
	$backsound.play()

func _process(_delta):
	if(obj_clicked && container):
		if (obj_clicked.dragging):   #&& container.get_parent()==component): solo se ilumina el correspondiente
			container.change()
			#emit_signal('obj_in') tambien se podria emitir una señal para cada uno..

func _on_Obj_clicked(obj):
	obj_clicked=obj
	component=obj_clicked.get_parent()


func _on_Obj_drop():
	if (container && container.get_parent()==component && desafio==obj_clicked.desafio && !fin):	# SOMBRA CORRECTA
		#obj_clicked.position= obj_clicked.final_position
		obj_clicked.lock(container.position)
		container.lock()
		colocados+= 1
		$correcto.play()
		emit_signal("score_gained",score_plus)
		emit_signal("show_scoreplus")
		if (obj_clicked.get_parent().name == 'llave'):
			emit_signal("show_tip",1)
			$tip_sound.play()
		elif(obj_clicked.get_parent().name == 'gasista' && !Main.tip_gasista):
			emit_signal("show_tip",2)
			$tip_sound.play()
			Main.tip_gasista=true

		if (colocados == 1):
			emit_signal("change_challenge",desafio+1)
			$llama/s_llama.show()
			$consigna1.hide()
			$consigna2.show()
			$change_desafio.play()
			$AnimationChallenge.play("Change2")
			$mano.position= Vector2(1866.76,272.96)
		elif (colocados == 6):
			emit_signal("change_challenge",desafio+1)
			$consigna2.hide()
			$consigna3.show()
			$change_desafio.play()
			$AnimationChallenge.play("Change3")
			$mano.position= Vector2(1866.76,347.96)
		elif (colocados == 9):
			game_over()
			$popup_sig/Time_over.hide()
	  
		score_current+=score_plus
		score_current=clamp(score_current,0,score_max)

	else:	
		if(container && !fin):		# SOMBRA INCORRECTA
			score_current-=score_minus
			score_current=clamp(score_current,0,score_max)
			$incorrecto.play()
			emit_signal("score_lost",score_minus)
			emit_signal("show_scoreminus")
			obj_clicked.position= obj_clicked.start_position
#		else:	# DROP en cualquier lado
#			if(obj_clicked.get_parent().name == 'gasista'): # GASISTA
#				obj_clicked.lock($gasista/s_gasista.position)
#			else:
		obj_clicked.position= obj_clicked.start_position
		
		
	obj_clicked=null
	component=null

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
	fin=true
	game_over()

func game_over():
	emit_signal("stop_timer")
	$win_level.play()
	Main.totalScore+=score_current
	$popup_sig.popup()

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

func _on_show_tip(tip):
	$Popup.popup()
	$Popup/Tip.animation="Tip"+str(tip)
	emit_signal("stop_timer")

func _on_Ok_pressed():
	pop.hide()
	emit_signal("start_timer")

func _on_siguiente_pressed():
	Main.select_level()
