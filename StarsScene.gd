extends Node2D

func _ready():
	$win.play()
	select_stars()
	#$HTTPRequest.connect("request_completed",self,"_on_request_completed")
	$HTTPRequest.set_download_file("res://Receta/receta.jpg")

func _on_Download_pressed():
	#$HTTPRequest.request("https://drive.google.com/uc?export=download&id=1ZK9pkwiM5AWHH_sPPeeS0oVB0l9eGklC")
	OS.shell_open("http://getupstudio.co/Metrogas/Recetario.pdf")

func select_stars():
	if(int(Main.totalScore)<=860):
		$Textandstars.animation="one"
	elif(int(Main.totalScore>860)&&int(Main.totalScore)<=1599):
		$Textandstars.animation="two"
	else:
		$Textandstars.animation="three"

func _on_Next_pressed():
	get_tree().change_scene_to(load("res://End.tscn"))
