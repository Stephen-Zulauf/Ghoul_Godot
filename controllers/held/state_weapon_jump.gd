class_name StateWeaponJump extends State

@export var ITEM : HeldRig
@export var ANIMATION : AnimationPlayer

func enter() -> void:
	pass

func update(_delta):
	if !get_parent().BUS.Jumping:
		if get_parent().BUS.Sprinting :
			transition.emit("stateWeaponSprint")
		elif get_parent().BUS.Walking :
			transition.emit("stateWeaponWalk")
		else:
			transition.emit("stateWeaponIdle")
