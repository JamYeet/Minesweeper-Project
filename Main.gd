extends Node2D

#var Tile = preload("res://Tile.tscn") #preloads the tile scene onto this scene
var tiles 


func _ready(): #Calls function when entering this scene
	
	#Spreads the tiles on the x and y axis every 54 pixels
	randomize()
	for r in range(Global.row): 
		for c in range(Global.col):
			var t = preload("res://Tile.tscn").instantiate()
			t.position = Vector2(r, c) * 54
			add_child(t)
	tiles = get_children()
	
	#Calls the set_bombs function
	set_bombs()

func set_bombs(): #function for setting bombs on random tiles
	var n = 0
	while n < Global.bombs_number: #Sets bombs until the number of bombs are met
		var tile = tiles[randi() % len(tiles)]
		if tile.is_bomb == false: #Control structure for making sure bombs don't stack/overlap on the same tile
			tile.set_bomb() #function called from the preloaded 'Tile' scene in line 3
			n += 1
