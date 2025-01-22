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
	Data = Data.duplicate(true)
	Data.Setup()
	$VBoxContainer/Frame/Face.texture = Data.Face
	$VBoxContainer/Frame.UpdateRarity(Data.Rarity)
	$VBoxContainer/Label.text = Data.GetFullName()
	$VBoxContainer/HBoxContainer/Label.text = str(Data.Cost)
	UpdateAffordability()

func UpdateAffordability():
	if is_instance_valid(Data) == false:
		return
	var bEnabled = Helper.GetShop().CanAfford(Data.Cost) and Helper.GetPlayerTeam().IsFull() == false
	disabled = !bEnabled
	if Helper.GetShop().CanAfford(Data.Cost) == false:
		$VBoxContainer/HBoxContainer/Label.modulate = Color.RED
	else:
		$VBoxContainer/HBoxContainer/Label.modulate = Color.WHITE
	
func _on_button_up():
	if disabled:
		return
		
	Helper.GetShop().ReduceMoney(Data.Cost)
	Helper.GetPlayerTeam().AddPog(Data)
	$VBoxContainer/Label.text = "SOLD OUT"
	$VBoxContainer/Frame.visible = false
	$VBoxContainer/HBoxContainer.visible = false
	modulate = Color.DIM_GRAY
	disabled = true
	Data = null
	


func _on_mouse_entered():
	if is_instance_valid(Data):
		Helper.GetCharInfoUI().UpdateInfo(Data)


func _on_mouse_exited():
	if is_instance_valid(Helper.GetCharInfoUI()):
		Helper.GetCharInfoUI().HideInfo()
