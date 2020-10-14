extends Node2D

func _ready():
	pass

func _on_Play_again_pressed():
	Main.levels=[0,0,0,0,0]
	Main.newgame=true
	get_tree().change_scene_to(load("res://Welcome.tscn"))

func _on_Homepage_pressed():
	OS.shell_open("https://vivisustentabilidad.com.ar/")
