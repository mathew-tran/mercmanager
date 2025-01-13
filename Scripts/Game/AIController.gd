extends Node

class_name AIController


func Run(charRef: Character, delta):
	charRef.CharacterData.UnitPersonality.Run(charRef, delta)
