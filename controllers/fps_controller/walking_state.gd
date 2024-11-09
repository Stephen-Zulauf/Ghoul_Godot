class_name WalkingState

extends PlayerMovementState

@export var SPEED: float = 5.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.25
@export var TOP_ANIMATION_SPEED: float = 2.2

func enter() -> void:
	ANIMATION.play("walking", -1.0,1.0)
	
func exit() -> void:
	ANIMATION.speed_scale = 1.0

func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED,ACCELERATION,DECELERATION)
	PLAYER.update_velocity()
	
	set_animation_speed(PLAYER.velocity.length())
	
	#state changes
	if Input.is_action_just_pressed("sprint") and PLAYER.is_on_floor():
		transition.emit("SprintingState")
		
	if Input.is_action_pressed("crouch") and PLAYER.is_on_floor():
		transition.emit("CrouchingState")
	
	if Input.is_action_just_pressed("jump") and PLAYER.is_on_floor():
		transition.emit("JumpingState")
		
	if PLAYER.velocity.length() == 0.0:
		transition.emit("IdleState")
		
func set_animation_speed(spd):
	var alpha = remap(spd, 0.0, SPEED, 0.0, 1.0 )
	ANIMATION.speed_scale = lerp(0.0, TOP_ANIMATION_SPEED, alpha)
	
