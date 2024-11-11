class_name StateWeaponJump extends State

@export var WEAPON : ControllerWeapon
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
