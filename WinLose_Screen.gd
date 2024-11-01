extends Control

var current_PB
var file
var saveFile
func _ready():	
	get_tree().paused = false
	#if player won, show the win text
	if Global.win == true:
		$Win_text.show()
	
	#if player lost, show the lose text
	elif Global.lose == true:
		$Lose_text.show()
	
	#functions called for showing current score, PB, and saving current score to text file storage
	load_file() #loads file to be read
	show_player_PB() #displays PB score
	show_player_score() #displays score
	save_file() #saves score if new PB score, else, saves current PB to text file again.

func load_file() -> String: #function for loading the text file
	var file_path = ""
	var content = ""
	match Global.restart_option:
		1: file_path = "res://EASYPB.txt"
		2: file_path = "res://MEDIUMPB.txt"
		3: file_path = "res://HARDPB.txt"
	var file = FileAccess.open(file_path, FileAccess.ModeFlags.READ)
	if file:
		content = file.get_as_text()
		file.close()
	else:
		return "Error: Could not open file."
	if int(content) == 0: #Converts contents in text file to 99999 (Only happens when Text file is new)
		content = str(99999)
	current_PB = content #Assign current_PB to whatever score is saved in the text file	
	return content

func save_file() -> void:
	var file_path = ""
	# Select the appropriate file based on the restart option
	match Global.restart_option:
		1:
			file_path = "res://EASYPB.txt"
		2:
			file_path = "res://MEDIUMPB.txt"
		3:
			file_path = "res://HARDPB.txt"

	# Open the file in WRITE mode
	var save_file = FileAccess.open(file_path, FileAccess.ModeFlags.WRITE)
	if save_file:
		save_file.store_string(str(int(current_PB)))  # Store the current PB as a string
		save_file.close()
	else:
		print("Error: Could not open file for writing.")
	
func _on_Restart_button_pressed(): #Restarts the minesweeper game and reloads the previous difficulty
	if Global.restart_option == 1:
		Global.easy_enabled()
	elif Global.restart_option == 2:
		Global.medium_enabled()
	elif Global.restart_option == 3:
		Global.hard_enabled()
	
	#Hides win/lose text
	$Lose_text.hide() 
	$Win_text.hide()
	
	
	get_tree().change_scene_to_file("res://Minesweeper.tscn") #Changes screen to the game
	


func _on_Main_Menu_button_pressed(): #Changes screen to the gamemode menu
	$Lose_text.hide() 
	$Win_text.hide()
	get_tree().change_scene_to_file("res://Gamemode_Menu.tscn")



func _on_Quit_button_pressed(): #Exits program	
	get_tree().quit()


func show_player_score(): #function for showing the player's score after winning
	if Global.win == true:
		if Global.restart_option == 1:
			$Player_score.text = str("EASY: "+str(int(Global.player_score)))
		elif Global.restart_option == 2:
			$Player_score.text = str("MEDIUM: "+str(int(Global.player_score)))
		elif Global.restart_option == 3:
			$Player_score.text = str("HARD: "+str(int(Global.player_score)))
	else:
		pass


func show_player_PB(): #function for showing and comparing PB score
	if Global.win == true:
		
		#Checks if player's score beats their PB score
		if int(current_PB) > int(Global.player_score): 
			
			#Saves player's score 
			current_PB = Global.player_score
			
			#Displays player's new PB if the player has won before
			if Global.restart_option == 1 and int(current_PB) != 99999:
				$Player_PB_score.text = str("New EASY Personal Best: "+str(int(current_PB)))
			elif Global.restart_option == 2 and int(current_PB) != 99999:
				$Player_PB_score.text = str("New MEDIUM Personal Best: "+str(int(current_PB)))
			elif Global.restart_option == 3 and int(current_PB) != 99999:
				$Player_PB_score.text = str("New HARD Personal Best: "+str(int(current_PB)))
		else:
			#if score doesn't beat PB score, display current PB
			if Global.restart_option == 1 and int(current_PB) != 99999:
				$Player_PB_score.text = str("EASY Personal Best: "+str(int(current_PB)))
			elif Global.restart_option == 2 and int(current_PB) != 99999:
				$Player_PB_score.text = str("MEDIUM Personal Best: "+str(int(current_PB)))
			elif Global.restart_option == 3 and int(current_PB) != 99999:
				$Player_PB_score.text = str("HARD Personal Best: "+str(int(current_PB)))
	elif Global.lose == true:
		#if player lost, display current PB
		if Global.restart_option == 1 and int(current_PB) != 99999:
			$Player_PB_score.text = str("EASY Personal Best: "+str(int(current_PB)))
		elif Global.restart_option == 2 and int(current_PB) != 99999:
			$Player_PB_score.text = str("MEDIUM Personal Best: "+str(int(current_PB)))
		elif Global.restart_option == 3 and int(current_PB) != 99999:
			$Player_PB_score.text = str("HARD Personal Best: "+str(int(current_PB)))
