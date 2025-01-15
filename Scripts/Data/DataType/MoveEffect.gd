extends Resource

class_name MoveEffect

enum SPAWN_TYPE {
	ON_OWNER,
	ON_TARGET
}
@export var MoveImage : Texture2D
@export var Duration : float
@export var SpawnType : SPAWN_TYPE

func PlayEffect(owner : Character, target : Character):
	var instance = load("res://Prefabs/UI/Projectile.tscn").instantiate()
	if SpawnType == SPAWN_TYPE.ON_OWNER:
		instance.global_position = owner.global_position
	else:
		instance.global_position = target.global_position
	
	instance.Setup(target.global_position, Duration, MoveImage)
	Helper.GetEffectsGroup().add_child(instance)
	await instance.Complete
