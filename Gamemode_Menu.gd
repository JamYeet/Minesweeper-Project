extends Control

func _on_Easy_button_pressed(): #Sends the player into the game with the easy difficulty enabled
	get_tree().change_scene_to_file("res://Minesweeper.tscn")
	Global.easy_enabled()
	
func _on_Medium_button_pressed(): #Sends the player into the game with the medium difficulty enabled
	get_tree().change_scene_to_file("res://Minesweeper.tscn")
	Global.medium_enabled()

func _on_Hard_button_pressed(): #Sends the player into the game with the hard difficulty enabled
	get_tree().change_scene_to_file("res://Minesweeper.tscn")
	Global.hard_enabled()

func _on_Back_button_pressed(): #Sends the player back to titlescreen
	get_tree().change_scene_to_file("res://Titlescreen.tscn")
	
