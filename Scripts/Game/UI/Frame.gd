extends TextureRect


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
