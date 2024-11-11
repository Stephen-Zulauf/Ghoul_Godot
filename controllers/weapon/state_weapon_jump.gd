class_name StateWeaponJump extends State

@export var WEAPON : ControllerWeapon
@export var ANIMATION : AnimationPlayer

@export var SPEED: float = 5.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.25
@export var TOP_ANIMATION_SPEED: float = 2.2

func enter() -> void:
	pass
	#if ANIMATION.is_playing() and ANIMATION.current_animation == "JumpEnd":
		#await ANIMATION.animation_finished
	#else:
		#ANIMATION.pause()

func update(delta):
	if !get_parent().BUS.Jumping:
		if get_parent().BUS.Sprinting :
			transition.emit("stateWeaponSprint")
		elif get_parent().BUS.Walking :
			transition.emit("stateWeaponWalk")
		else:
			transition.emit("stateWeaponIdle")
