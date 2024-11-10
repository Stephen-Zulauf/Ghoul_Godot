class_name StateWeaponTest extends State

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
	pass
	#WEAPON.update_gravity(delta)
	#WEAPON.update_input(SPEED,ACCELERATION,DECELERATION)
	#WEAPON.update_velocity()
	#
	#if Input.is_action_just_pressed("crouch") and WEAPON.is_on_floor():
		#transition.emit("stateCrouch")
	#
	#if WEAPON.velocity.length() > 0.0 and WEAPON.is_on_floor():
		#transition.emit("stateWalk")
	#
	#if Input.is_action_just_pressed("jump") and WEAPON.is_on_floor():
		#transition.emit("stateJump")
	#
	#if WEAPON.velocity.y < -3.0 and !WEAPON.is_on_floor():
		#transition.emit("stateFall")
