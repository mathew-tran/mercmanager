extends CanvasLayer

func _ready():
	visible = true
	Helper.GetBattleSystem().TellGameState.connect(OnTellGameState)
	

func OnTellGameState(state : BattleSystem.GAME_STATE):
	if state == BattleSystem.GAME_STATE.PLAYER_WIN:
		visible = true
	else:
		print("Game Over!")
		get_tree().reload_current_scene()


func _on_button_button_up():
	visible = false
	Helper.GetBattleSystem().StartRound()
