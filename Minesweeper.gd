extends Node

func _on_Give_up_pressed(): #forfeits the game and sends user to WinLose_Screen scene
	Global.lose = true
	get_tree().change_scene_to_file("res://WinLose_Screen.tscn")
	
