extends Control

func _on_Play_button_pressed(): #Sends screen into game mode selection
	get_tree().change_scene_to_file("res://Gamemode_Menu.tscn")
	
func _on_Howtoplay_button_pressed(): #Directs player to a website guide 
	OS.shell_open("https://minesweepergame.com/strategy/how-to-play-minesweeper.php")

func _on_Exit_button_pressed(): #Exits the program	
	get_tree().quit()
