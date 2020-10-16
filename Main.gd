extends Node2D

var level_seleted=2
var time_challenge=[61,41]
var scoreplus_challenge=[30,100,10,0]
var scoreminus_challenge=[25,50,0,0]
var selectedlevel
var totalScore=0
var levels=[0,0,0,0,0]
var newgame=true
var tip_gasista=false

var sprite_texture_plus=["S30",	"S100",	"S10"]

var sprite_texture_minus=["S25","S50"]

func select_level():
	randomize()
	var scene
	selectedlevel=int(rand_range(0,3))
	#selectedlevel=2
	if(levels[selectedlevel]==1):
		var i=0
		while(i<=3&&levels[i]==1):
			i+=1
		selectedlevel=i
		if(i==4):
			scene=load("res://StarsScene.tscn")
		else:
			scene=load("res://Levels/Level"+str(selectedlevel+1)+".tscn")
	else:
		scene=load("res://Levels/Level"+str(selectedlevel+1)+".tscn")
		if((newgame) && selectedlevel==2):#o la que vaya a ser el banio
			selectedlevel+=1
			scene = load("res://Levels/Level"+str(selectedlevel+1)+".tscn")
	levels[selectedlevel]=1
	newgame=false
	get_tree().change_scene_to(scene)

func non_zero(score):
	if(score<0):
		return 0
	else:
		return score
