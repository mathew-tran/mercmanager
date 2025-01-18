extends Button

var CharInfoRef : CharacterInfo

func Setup(character : CharacterInfo):
	if is_instance_valid(character):
		CharInfoRef = character
		$Face.texture = CharInfoRef.Face
		$Label.text = CharInfoRef.Name
		$TextureRect.modulate = Color.DIM_GRAY
	else:
		CharInfoRef = null
		$Face.texture = null
		$Label.text = ""
		$TextureRect.modulate = Color.DARK_GRAY


func _on_mouse_entered():
	if is_instance_valid(CharInfoRef):
		Helper.GetCharInfoUI().UpdateInfo(CharInfoRef)
	else:
		Helper.GetCharInfoUI().HideInfo()


func _on_mouse_exited():
	Helper.GetCharInfoUI().HideInfo()
