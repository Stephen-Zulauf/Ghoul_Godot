class_name StateWeaponCrouch extends State

@export var ITEM : HeldRig
@export var ANIMATION : AnimationPlayer

func enter() -> void:
	pass

func update(_delta):
	if !get_parent().BUS.Crouching:
		transition.emit("stateWeaponIdle")
