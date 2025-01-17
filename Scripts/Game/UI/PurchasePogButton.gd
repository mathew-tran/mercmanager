extends Button

var Data : CharacterInfo

func _ready():
	Helper.GetShop().UpdateMoney.connect(OnUpdateMoney)
	Helper.GetPlayerTeam().TeamUpdate.connect(OnUpdateTeam)
	
func OnUpdateTeam():
	UpdateAffordability()
	
func OnUpdateMoney():
	UpdateAffordability()
	
func Setup(charInfo : CharacterInfo):
	Data = charInfo
	$VBoxContainer/Frame/Face.texture = Data.Face
	$VBoxContainer/Label.text = Data.Name
	$VBoxContainer/HBoxContainer/Label.text = str(Data.Cost)
	UpdateAffordability()

func UpdateAffordability():
	var bEnabled = Helper.GetShop().CanAfford(Data.Cost) and Helper.GetPlayerTeam().IsFull() == false
	disabled = !bEnabled
	if Helper.GetShop().CanAfford(Data.Cost) == false:
		$VBoxContainer/HBoxContainer/Label.modulate = Color.RED
	else:
		$VBoxContainer/HBoxContainer/Label.modulate = Color.WHITE
	
func _on_button_up():
	Helper.GetShop().ReduceMoney(Data.Cost)
	Helper.GetPlayerTeam().AddPog(Data)
	$VBoxContainer/Label.text = "SOLD OUT"
	modulate = Color.DIM_GRAY
	disabled = true
