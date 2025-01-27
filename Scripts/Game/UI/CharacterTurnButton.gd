extends Button

class_name CharacterTurnButton

var CharReference : Character
	
func Setup(charRef : Character):
	$ActivePanel.visible = false
	$Frame.UpdateFrame(charRef)
	$Frame/Face.texture = charRef.CharacterData.Face
	$Name.text = charRef.CharacterData.GetFullName()
	charRef.GetHealthComponent().Update.connect(OnHealthUpdate)
	charRef.GetHealthComponent().TakenDamage.connect(OnTakenDamage)
	charRef.GetHealthComponent().OnDeath.connect(OnDeath)
	CharReference = charRef
	charRef.ActiveUpdate.connect(OnActiveUpdate)
	OnHealthUpdate()
	
	$Frame.ShowRarity(charRef.Team == Character.TEAM.PLAYER)
	
func OnHealthUpdate():
	$HP.value = CharReference.GetHealthComponent().GetHealthPercent() * 100
	$HP/Label.text = CharReference.GetHealthComponent().GetHealthString()
	
func OnTakenDamage():
	$HitPanel.visible = true
	var tween = create_tween()
	tween.tween_property($HitPanel, "global_position", global_position + Vector2(32,0), .1)
	await tween.finished
	tween = create_tween()
	tween.tween_property($HitPanel, "global_position", global_position + Vector2(-32,0), .1)
	await tween.finished
	
	$HitPanel.visible = false
	
func OnDeath():
	modulate = Color.SLATE_GRAY
	
func OnActiveUpdate(bActive):
	$ActivePanel.visible = bActive


func _on_mouse_entered():
	if is_instance_valid(CharReference):
		Helper.GetCharInfoUI().UpdateInfo(CharReference.CharacterData)
		
func _on_mouse_exited():
	if is_instance_valid(Helper.GetCharInfoUI()):
		Helper.GetCharInfoUI().HideInfo()
