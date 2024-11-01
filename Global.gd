extends Node

#Global variables used throughout the scenes

#Rows and columns for the number of tiles depending on the difficulty
var row = 0
var col = 0

#Win condition variables
var bombs_number = 0
var flag_number = 0
var bombs_flagged = 0 
var tiles_opened = 0
var tiles_to_open = 0

#Variables to determine the status of the game
var win = false
var lose = false

#Restart variable used for restarting the same difficulty (1 = easy, 2 = medium, 3 = hard)
var restart_option = 0

#Variables used to save, start and pause the game's timer
var first_move = false 
var score_time = 0
var player_score = 0

func easy_enabled(): #Resets global variables and sets variables to 'easy' difficulty
	row = 8
	col = 6
	bombs_number = 6 
	bombs_flagged = 0 
	flag_number = 6
	tiles_to_open = 42
	tiles_opened = 0
	win = false
	lose = false
	restart_option = 1
	first_move = false
	score_time = 0 


func medium_enabled(): #Resets global variables and sets variables to 'medium' difficulty
	row = 10
	col = 8
	bombs_number = 10 
	bombs_flagged = 0 
	flag_number = 10
	tiles_to_open = 70
	tiles_opened = 0
	win = false
	lose = false
	restart_option = 2
	first_move = false 
	score_time = 0


func hard_enabled(): #Resets global variables and sets variables to 'hard' difficulty
	row = 12
	col = 10
	bombs_number = 15
	bombs_flagged = 0 
	flag_number = 15
	tiles_to_open = 105
	tiles_opened = 0
	win = false
	lose = false
	restart_option = 3
	first_move = false 
	score_time = 0
