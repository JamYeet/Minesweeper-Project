extends Label

#variables for the score timer
var time = 0
var timer_on = false
var Time_passed 

func _physics_process(delta): #_physics_process is called every frame (used for timer)
	
	#When player makes their first move, start timer
	if Global.first_move == true: 
		timer_on = true
		if (timer_on):
			time += delta
		
		var mils = fmod(time,1)*1000
		var secs = fmod(time,60)
	
		var time_passed = "%03d" % [secs]
		Time_passed = time_passed
		text = Time_passed
		pass
	
	#When player loses or wins, stop timer and save timer in Global scene.
	if Global.win == true or Global.lose == true:
		timer_on = false
		Global.score_time = Time_passed
		Global.player_score = Global.score_time
		pass
