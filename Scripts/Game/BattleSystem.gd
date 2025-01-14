extends Node2D

@onready var Characters = $Characters

enum GAME_STATE {
	PLAYING,
	OVER
}

var CurrentState = GAME_STATE.PLAYING
func _ready():
	PlayGame()
	
	
func PlayGame():
	var index = 0
	while CurrentState == GAME_STATE.PLAYING:
		await Characters.get_child(index).RunInput()
		index += 1
		if index >= len(Characters.get_children()):
			index = 0
		await get_tree().create_timer(.5).timeout
		
	
	
