class_name StateWeaponCrouch extends State

@export var WEAPON : ControllerWeapon
@export var ANIMATION : AnimationPlayer

func enter() -> void:
	pass

func update(delta):
	if !get_parent().BUS.Crouching:
		transition.emit("stateWeaponIdle")
