extends Panel

class_name MoveInfoButton

func Setup(moveInfo : Move):
	$Control.visible = false
	$VBoxContainer.visible = false
	$Strikeout.visible = false
	$Name.text = ""
	modulate = Color.WHITE
	$Description.text = ""
	if is_instance_valid(moveInfo):
		$Control.visible = true
		$VBoxContainer.visible = true
		$Name.text = moveInfo.Name.to_upper()
		$VBoxContainer/AccuracyValue.text = str(moveInfo.PercentChance) + "%"
		$VBoxContainer/DamageValue.text = moveInfo.GetDamageValueText()
		$Description.text = moveInfo.MoveDescription
		$Control/MoveTexture.texture = moveInfo.Effect.MoveImage
	else:
		modulate = Color.DIM_GRAY
		$Strikeout.visible = true
		
