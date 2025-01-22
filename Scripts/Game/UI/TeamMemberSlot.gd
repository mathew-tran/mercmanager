extends Button

var CharInfoRef : CharacterInfo

var Index = 0
func Setup(character : CharacterInfo, index):
	$Frame.visible = false
	if is_instance_valid(character):
		CharInfoRef = character
		$Face.texture = CharInfoRef.Face
		$Label.text = CharInfoRef.GetFullName()
		Index = index
		$Frame.UpdateRarity(CharInfoRef.Rarity)
		$Frame.visible = true
	else:
		CharInfoRef = null
		$Face.texture = null
		$Label.text = ""
		Index = -1

func GetSaleCost():
	return int(max(1, round(CharInfoRef.Cost * .50)))

func _on_mouse_entered():
	if is_instance_valid(CharInfoRef):
		Helper.GetCharInfoUI().UpdateInfo(CharInfoRef)
		$SellPopup.visible = true
		$SellPopup/HBoxContainer/Amount.text = str(GetSaleCost())
	else:
		Helper.GetCharInfoUI().HideInfo()


func _on_mouse_exited():
	Helper.GetCharInfoUI().HideInfo()
	$SellPopup.visible = false


func _on_button_up():
	if is_instance_valid(CharInfoRef):
		Helper.GetShop().AddMoney(GetSaleCost())
		Helper.GetPlayerTeam().RemovePog(Index)
		Setup(null, -1)
		$SellPopup.visible = false
