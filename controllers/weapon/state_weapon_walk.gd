class_name StateWeaponWalk extends State

@export var WEAPON : ControllerWeapon
@export var ANIMATION : AnimationPlayer

@export var SPEED: float = 5.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.25
@export var TOP_ANIMATION_SPEED: float = 2.2

func enter() -> void:
	print("weapon state walk")
	#if ANIMATION.is_playing() and ANIMATION.current_animation == "JumpEnd":
		#await ANIMATION.animation_finished
	#else:
		#ANIMATION.pause()

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
