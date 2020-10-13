extends Sprite

export(int) var maxtimer=40
var current_time
signal game_over()

func _ready():
	if(Main.level_seleted==1):
		maxtimer=Main.time_challenge[Main.level_seleted-1]
	else:
		maxtimer=Main.time_challenge[Main.level_seleted-1]
	current_time=maxtimer
	$Clock.max_value=maxtimer
	$Timer.start()

func _on_Timer_timeout():
	var aux=current_time
	current_time-=1
	if(current_time==0):
		$Number.text=str(current_time)
		$Clock.value=current_time
		emit_signal("game_over")
		$Timer.stop()
	else:
		$Number.text=str(current_time)
		$Clock.value=current_time
		if(current_time==15):
			$Timer.wait_time=0.5

func _on_stop_timer():
	$Timer.stop()

func _on_start_timer():
	$Timer.start()
