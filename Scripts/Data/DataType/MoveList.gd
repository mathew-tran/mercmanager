extends Resource

class_name MoveList

@export var Move1 : Move
@export var Move2 : Move


func DecideRandomMove():
	var validMoves = []
	if is_instance_valid(Move1):
		validMoves.append(Move1)
	if is_instance_valid(Move2):
		validMoves.append(Move2)
	validMoves.shuffle()
	return validMoves[0]
