extends Sprite2D

func _ready():
	visible = false
	
func GetSpawnPosition():
	return $PositionToSpawn.global_position
