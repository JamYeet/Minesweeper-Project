extends Node2D

#variables for establishing conditions of a tile
var is_cover = true
var flagged = false
var is_bomb = false

func _on_Control_gui_input(event) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			uncover()
	#Calls flag function on right click
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			toggle_flag()

func on_player_winlose() -> void: #function for when the player wins or loses
	get_tree().paused = true #disables user input when player wins/loses
	await get_tree().create_timer(2.0).timeout #waits 2 seconds
	get_tree().change_scene_to_file("res://WinLose_Screen.tscn") #switches to winlose screen
		 #enables user input again




func set_bomb(): #function for setting a bomb on an individual tile
	is_bomb = true #the tile has a bomb 
	$Bomb.show()
	$Label.hide()


func uncover(): #function for uncovering a tile
	
	#if the tile is not flagged and a cover exists, player can uncover tile
	if flagged == false and is_cover == true:
		$Cover.hide()
		
		#if the tile is a bomb, player loses
		if is_bomb == true:
			Global.first_move = false
			Global.lose = true
			$Red_fade.show()
			on_player_winlose() #calls on_player_winlose() function
		
		#if the tile is not a bomb, game proceeds
		elif is_bomb == false:	
			Global.first_move = true 
			Global.tiles_opened += 1 #adds 1 to tiles opened for win condition
			is_cover = false #cover has been removed, so is_cover is false
			
			#displays the number of bombs around the uncovered tile in a 1 tile radius
			var count_surrounds = 0
			for tile in get_surrounds():
				if tile.is_bomb:
					count_surrounds += 1
			if count_surrounds > 0:
				$Label.text = str(count_surrounds)
			else:
				for tile in get_surrounds():
					if tile.is_cover:
						tile.uncover()
		
		#Win condition. If bombs needed to be flagged have been flagged and tiles to be opened have been opened, player wins
		if Global.bombs_flagged == Global.bombs_number and Global.tiles_opened == Global.tiles_to_open:
			Global.first_move = false #resets first_move to default value to stop the timer
			Global.win = true
			on_player_winlose() 


func get_surrounds(): #function for getting a tile's surroundings for neighbouring bombs
	var surrounds = [] #sets variable to an array
	
	#radius is set to 1 tile, which is 54 pixels
	var offsets = [ 
		(Vector2.UP + Vector2.LEFT) * 54,
		(Vector2.UP) * 54,
		(Vector2.UP + Vector2.RIGHT) * 54,
		(Vector2.LEFT) * 54,
		(Vector2.RIGHT) * 54,
		(Vector2.DOWN + Vector2.LEFT) * 54,
		(Vector2.DOWN) * 54,
		(Vector2.DOWN + Vector2.RIGHT) * 54,
	]
	#add the tile's surroundings to the array for 54 pixels around the tile
	for offset in offsets: 	
		for tile in get_parent().tiles:  
			if tile.position  == position + offset: 
				surrounds.append(tile)
	return surrounds 


func toggle_flag(): #function for toggling on and off a flag on a tile
	#Control structures, if the cover is still on, proceed
	if is_cover:
		
		#if the tile is not flagged, flag the tile
		if flagged == false:
			$Flag.show()
			Global.first_move = true 
			flagged = true
			
			#if the flagged tile contains a bomb, adds 1 to bombs flagged for win condition
			if is_bomb == true:
				Global.bombs_flagged += 1
				
				#Check 	if player has won. Win condition
				if Global.bombs_flagged == Global.bombs_number and Global.tiles_opened == Global.tiles_to_open:
					Global.first_move = false
					Global.win = true
					on_player_winlose()
		
		#If the tile is already flagged, unflag the tile
		elif flagged == true:
			$Flag.hide()
			
			#if the unflagged tile contains a bomb, remove 1 to bombs flagged for win condition
			if is_bomb == true:
				Global.bombs_flagged -= 1 
			flagged = false
			
		#if the cover has already been uncovered, pass
		elif is_cover == false:
			pass
