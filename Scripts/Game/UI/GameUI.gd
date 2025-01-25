extends CanvasLayer

func _ready():
	visible = true
	Helper.GetBattleSystem().TellGameState.connect(OnTellGameState)
	$Shop.visible = true

func OnTellGameState(state : BattleSystem.GAME_STATE):
	if state == BattleSystem.GAME_STATE.PLAYER_WIN:
		$Shop.visible = true
		$Shop.PopulateStock()
		Helper.GetCharInfoUI().HideInfo()
	elif state == BattleSystem.GAME_STATE.PLAYER_LOSE:
		print("Game Over!")
		get_tree().reload_current_scene()

func _on_shop_start_round_clicked():
	$Shop.visible = false
	Helper.GetBattleSystem().StartRound()
