class_name StateWeaponSprint extends State

@export var WEAPON : ControllerWeapon
@export var ANIMATION : AnimationPlayer

@export var SPEED: float = 5.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.25
@export var TOP_ANIMATION_SPEED: float = 2.2

func enter() -> void:
	print("weapon sprint")
	#if ANIMATION.is_playing() and ANIMATION.current_animation == "JumpEnd":
		#await ANIMATION.animation_finished
	#else:
		#ANIMATION.pause()

func update(delta):
	#CONTROLLER.update_gravity(delta)
	#CONTROLLER.update_input(SPEED,ACCELERATION,DECELERATION)
	#CONTROLLER.update_velocity()
	
	#set_animation_speed(CONTROLLER.velocity.length())
	
	if get_parent().BUS.Walking:
		transition.emit("stateWeaponWalk")
	
	if get_parent().BUS.Crouching:
		transition.emit("stateWeaponCrouch")
		
	if get_parent().BUS.Jumping:
		transition.emit("stateWeaponJump")
	
	if get_parent().BUS.Falling:
		transition.emit("stateWeaponFall")
	
#func set_animation_speed(spd) -> void:
	#var alpha = remap(spd, 0.0, SPEED, 0.0, 1.0)
	#ANIMATION.speed_scale = lerp(0.0, TOP_ANIM_SPEED, alpha)
