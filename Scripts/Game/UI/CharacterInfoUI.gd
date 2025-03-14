extends Panel

class_name CharacterInfoUI

var yOffset = 0

func _ready():
	HideInfo()
	
func _input(event):
	if visible:
		if event.is_action_pressed("right_click"):
			HideInfo()
		
func _process(delta):
	if visible:
		var windowSize = Vector2(get_viewport().get_visible_rect().size) 
		var scaledSize = GetBounds()
		var newPosition = get_global_mouse_position() + Vector2(16, 32)
		if newPosition.x > windowSize.x - scaledSize.x:
			newPosition.x = windowSize.x - scaledSize.x
		if newPosition.y > windowSize.y - scaledSize.y:
			newPosition.y = windowSize.y - scaledSize.y
		global_position = newPosition
			
func UpdateInfo(charInfo : CharacterInfo):
	$VBoxContainer/Face.texture = charInfo.Face
	$Name.text = charInfo.GetFullName()
	$VBoxContainer2/HPValue.text = str(charInfo.StatValues.HP)
	$VBoxContainer2/DamageValue.text = str(charInfo.StatValues.Damage)
	$GridContainer/MoveInfoButton.Setup(charInfo.Moves.Move1)
	$GridContainer/MoveInfoButton2.Setup(charInfo.Moves.Move2)
	$Frame.UpdateRarity(charInfo.Rarity)
	
	for child in $TraitsPanel.get_children():
		child.queue_free()
	
	yOffset = 0
	for charTrait in charInfo.Traits:
		var instance = load("res://Prefabs/UI/TraitText.tscn").instantiate()
		instance.Setup(charTrait.GetTraitText())
		$TraitsPanel.add_child(instance)
	
	yOffset = ($TraitsPanel.size * $TraitsPanel.scale).y
	visible = true
	
func HideInfo():
	visible = false
	yOffset = 0

func GetBounds():
	var intendedSize = size * scale
	intendedSize.y += yOffset
	return intendedSize
