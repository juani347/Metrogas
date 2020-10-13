extends Node2D

export (PackedScene) var Video
var aux

func _ready():
	$Start.disabled=true
	aux=get_node("Popup")

func _on_HowToPlay_pressed():
	#aux.show()
	$Popup.popup()
	$sound.play()

func _on_Level1_pressed():
	Main.level_seleted=1
	$Level1.disabled=true
	$Level2.disabled=false
	$Start.disabled=false
	$Level1.modulate=Color(1, 1, 1, 1)
	$Level2.modulate=Color(1, 1, 1, 0.588235)

func _on_Level2_pressed():
	Main.level_seleted=2
	$Level1.disabled=false
	$Level2.disabled=true
	$Start.disabled=false
	$Level1.modulate=Color(1, 1, 1, 0.588235)
	$Level2.modulate=Color(1, 1, 1, 1)

func _on_Start_pressed():
	get_tree().change_scene_to(Video)

func _on_Close_popup_pressed():
	aux.hide()
