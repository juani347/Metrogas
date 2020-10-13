extends Node2D

func _ready():
	#$Button.disabled=true
	$Button.disabled=false
	$VideoPlayer.play()

func _on_VideoPlayer_finished():
	Main.select_level()

func _on_Button_pressed():
	Main.select_level()
