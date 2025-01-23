extends Container

func _ready():
	Helper.GetBattleSystem().TellGameState.connect(OnTellGameState)
	Clear()
func Clear():
	for child in get_children():
		child.queue_free()
		
func OnTellGameState(state : BattleSystem.GAME_STATE):
	if state == BattleSystem.GAME_STATE.PLAYING:
		Clear()
		
		var characters = Helper.GetCharacterHolder()[0]
		
		for character in characters.get_children():
			var instance = load("res://Prefabs/UI/CharacterTurnButton.tscn").instantiate()
			instance.Setup(character)
			add_child(instance)
			
	elif state == BattleSystem.GAME_STATE.PLAYER_WIN:
		Clear()
