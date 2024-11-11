class_name StateWeaponWalk extends State

@export var WEAPON : ControllerWeapon
@export var ANIMATION : AnimationPlayer

func enter() -> void:
	pass

func update(delta):
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

func _physics_process(delta: float) -> void:
	WEAPON.update_sway(delta)
