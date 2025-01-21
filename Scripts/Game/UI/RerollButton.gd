extends Button

var DefaultCost = 2

var CurrentCost = 2
var GrowthRate = 2


func _ready():
	Helper.GetBattleSystem().TellGameState.connect(OnTellGameState)
	Reset()
	
func _on_button_up():
	if Helper.GetShop().CanAfford(CurrentCost):
		Helper.GetShop().ReduceMoney(CurrentCost)
		Helper.GetShop().PopulateStock()
		CurrentCost += GrowthRate
		UpdateUI()

func OnTellGameState(newState : BattleSystem.GAME_STATE):
	if newState == BattleSystem.GAME_STATE.PLAYER_WIN:
		Reset()

func UpdateUI():
	$HBoxContainer/Amount.text = str(CurrentCost)
	if Helper.GetShop().CanAfford(CurrentCost):
		$HBoxContainer/Label.modulate = Color.WHITE
		$HBoxContainer/Amount.modulate = Color.WHITE
	else:
		$HBoxContainer/Label.modulate = Color.RED
		$HBoxContainer/Amount.modulate = Color.RED

func Reset():
	CurrentCost = DefaultCost
	UpdateUI()
	
