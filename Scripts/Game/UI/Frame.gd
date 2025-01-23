extends TextureRect


func UpdateFrame(charRef : Character):
	UpdateRarity(charRef.CharacterData.Rarity)
	if charRef.Team == Character.TEAM.ENEMY:
		self_modulate = "c93864ff"
	else:
		self_modulate = "35cbc8ff"
		
func UpdateRarity(rarity : CharacterInfo.RARITY):
	match rarity:
		CharacterInfo.RARITY.NORMAL:
			$TextureRect.texture = load("res://Art/UI/Rarity/1.png")
		CharacterInfo.RARITY.RARE:
			$TextureRect.texture = load("res://Art/UI/Rarity/2.png")
		CharacterInfo.RARITY.LEGENDARY:
			$TextureRect.texture = load("res://Art/UI/Rarity/3.png")
		
func ShowRarity(bShow):
	$TextureRect.visible = bShow
