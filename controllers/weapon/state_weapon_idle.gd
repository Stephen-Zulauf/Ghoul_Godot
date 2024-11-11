class_name StateWeaponIdle extends State

@export var WEAPON : ControllerWeapon
@export var ANIMATION : AnimationPlayer

@export var SPEED: float = 5.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.25
@export var TOP_ANIMATION_SPEED: float = 2.2

func enter() -> void:
	if get_parent().BUS.Idle:
		print("weapon is in idle")
	else:
		print("failed")

func update(delta):
	#CONTROLLER.update_gravity(delta)
	#CONTROLLER.update_input(SPEED,ACCELERATION,DECELERATION)
	#CONTROLLER.update_velocity()
	
	if get_parent().BUS.Crouching :
		transition.emit("stateWeaponCrouch")
	
	if get_parent().BUS.Walking:
		transition.emit("stateWeaponWalk")
	
	if get_parent().BUS.Jumping:
		transition.emit("stateWeaponJump")
	
	if get_parent().BUS.Falling:
		transition.emit("stateWeaponFall")
