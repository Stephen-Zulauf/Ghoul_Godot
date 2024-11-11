class_name StateWeaponFall extends State

@export var WEAPON : ControllerWeapon
@export var ANIMATION : AnimationPlayer

func enter() -> void:
	pass
	
func update(_delta):
	#state changes
	if get_parent().BUS.Sprinting:
		transition.emit("stateWeaponSprint")
		
	if get_parent().BUS.Crouching:
		transition.emit("stateWeaponCrouch")
	
	if get_parent().BUS.Walking:
		transition.emit("stateWeaponWalk")
	
	if get_parent().BUS.Jumping:
		transition.emit("stateWeaponJump")
		
	if get_parent().BUS.Falling:
		transition.emit("stateWeaponFall")
		
	if get_parent().BUS.Idle:
		transition.emit("stateWeaponIdle")
