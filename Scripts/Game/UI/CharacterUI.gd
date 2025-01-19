extends Control

var CharacterRef : Character

func Setup(char : Character):
	CharacterRef = char
	$Face.texture = char.CharacterData.Face
	$ActiveUI/Name.text = char.CharacterData.GetFullName()
	char.GetHealthComponent().Setup(char)
	char.GetHealthComponent().Update.connect(OnUpdate)
	char.GetHealthComponent().OnDeath.connect(OnDeath)
	if char.Team == Character.TEAM.ENEMY:
		$ActiveUI/Frame.modulate = "c93864ff"
	else:
		$ActiveUI/Frame.modulate = "35cbc8ff"
	OnUpdate()
	SetActive(false)
	
func SetActive(bActive):
	$ActiveUI.visible = bActive
	
func OnUpdate():
	$ActiveUI/HP/Label.text = CharacterRef.GetHealthComponent().GetHealthString()
	$ActiveUI/HP.value = CharacterRef.GetHealthComponent().GetHealthPercent() * 100
	
func OnDeath():
	$Face.rotation_degrees = 90
	modulate = "737373"
	CharacterRef.z_as_relative = false
	CharacterRef.z_index = -100
	$ActiveUI.visible = false
	
func Tell(message):
	if message != "":
		await $SpeechBubble.Show(message)
	else:
		await $SpeechBubble.Hide()
