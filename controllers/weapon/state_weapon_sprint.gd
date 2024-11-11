class_name StateWeaponSprint extends State

@export var WEAPON : ControllerWeapon
@export var ANIMATION : AnimationPlayer

func enter() -> void:
	pass
	#if ANIMATION.is_playing() and ANIMATION.current_animation == "JumpEnd":
		#await ANIMATION.animation_finished
	#else:
		#ANIMATION.pause()

func update(_delta):
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
	
func _physics_process(delta: float) -> void:
	WEAPON.update_sway(delta)
