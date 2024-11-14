class_name StateWeaponWalk extends State

@export var ITEM : ControllerHeld
@export var ANIMATION : AnimationPlayer

func enter() -> void:
	pass

func update(_delta):
	#state changes
	if get_parent().BUS.Sprinting:
		transition.emit("stateWeaponSprint")
		
	if get_parent().BUS.Crouching:
		transition.emit("stateWeaponCrouch")
	
	if get_parent().BUS.Jumping:
		transition.emit("stateWeaponJump")
		
	if get_parent().BUS.Idle:
		transition.emit("stateWeaponIdle")
		
	if get_parent().BUS.Falling:
		transition.emit("stateWeaponFall")

func _physics_process(_delta: float) -> void:
	pass
	#WEAPON.update_sway(delta)
