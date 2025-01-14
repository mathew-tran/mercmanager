extends Resource

class_name MoveList

@export var Move1 : Move
@export var Move2 : Move
@export var Move3 : Move
@export var Move4 : Move

func DecideRandomMove():
	var validMoves = []
	if is_instance_valid(Move1):
		validMoves.append(Move1)
	if is_instance_valid(Move2):
		validMoves.append(Move2)
	if is_instance_valid(Move3):
		validMoves.append(Move3)
	if is_instance_valid(Move4):
		validMoves.append(Move4)
	validMoves.shuffle()
	return validMoves[0]
