extends Button

var CharInfoRef : CharacterInfo

func Setup(character : CharacterInfo):
	$Frame.visible = false
	if is_instance_valid(character):
		CharInfoRef = character
		$Face.texture = CharInfoRef.Face
		$Label.text = CharInfoRef.GetFullName()

		$Frame.UpdateRarity(CharInfoRef.Rarity)
		$Frame.visible = true
	else:
		CharInfoRef = null
		$Face.texture = null
		$Label.text = ""



func _on_mouse_entered():
	if is_instance_valid(CharInfoRef):
		Helper.GetCharInfoUI().UpdateInfo(CharInfoRef)
	else:
		Helper.GetCharInfoUI().HideInfo()


func _on_mouse_exited():
	Helper.GetCharInfoUI().HideInfo()
