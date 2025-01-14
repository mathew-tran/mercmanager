extends Node2D

@onready var Characters = $Characters

enum GAME_STATE {
	PLAYING,
	PLAYER_WIN,
	PLAYER_LOSE
}

var CurrentState = GAME_STATE.PLAYING
func _ready():
	PlayGame()
	
	
func PlayGame():
	var index = 0
	while CurrentState == GAME_STATE.PLAYING:
		Helper.GetFollowCamera().FocusObject(Characters.get_child(index))
		await Helper.GetFollowCamera().CloseToObject
		await Characters.get_child(index).RunInput()
		
		
		if IsPlayerDead():
			CurrentState = GAME_STATE.PLAYER_LOSE
			break
		
		if IsEnemyDead():
			CurrentState = GAME_STATE.PLAYER_WIN
			break
			
		index += 1
		if index >= len(Characters.get_children()):
				index = 0
				
		while IsUnitAlive(index) == false:
			index += 1
			if index >= len(Characters.get_children()):
				index = 0
		
		
				
		await get_tree().create_timer(.5).timeout
		
	
func IsUnitAlive(index):
	return Characters.get_child(index).GetHealthComponent().IsAlive()
	
func IsPlayerDead():
	var units = Helper.GetPlayerTeamUnits()
	for unit in units:
		if unit.GetHealthComponent().IsAlive():
			return false
	return true
	
func IsEnemyDead():
	var units = Helper.GetOpponentTeamUnits()
	for unit in units:
		if unit.GetHealthComponent().IsAlive():
			return false
	return true
