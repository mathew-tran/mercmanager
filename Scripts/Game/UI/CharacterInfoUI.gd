extends Panel

class_name CharacterInfoUI

func _ready():
	HideInfo()
	
func _process(delta):
	if visible:
		var windowSize = Vector2(get_viewport().get_visible_rect().size) 
		var scaledSize = size.x * scale
		var newPosition = get_global_mouse_position() + Vector2(16, 16)
		if newPosition.x > windowSize.x - scaledSize.x:
			newPosition.x = windowSize.x - scaledSize.x
		global_position = newPosition
			
func UpdateInfo(charInfo : CharacterInfo):
	$VBoxContainer/Face.texture = charInfo.Face
	$VBoxContainer/Name.text = charInfo.Name
	$VBoxContainer2/HPValue.text = str(charInfo.StatValues.HP)
	$VBoxContainer2/DamageValue.text = str(charInfo.StatValues.Damage)
	$GridContainer/MoveInfoButton.Setup(charInfo.Moves.Move1)
	$GridContainer/MoveInfoButton2.Setup(charInfo.Moves.Move2)
	visible = true
	
func HideInfo():
	visible = false
