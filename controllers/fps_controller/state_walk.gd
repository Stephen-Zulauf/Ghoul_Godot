class_name StateWalk extends State

@export var SPEED: float = 5.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.25
@export var TOP_ANIMATION_SPEED: float = 2.2

@export var ANIMATION: AnimationPlayer
@export var CONTROLLER: Controller

func enter() -> void:
	if ANIMATION.is_playing() and ANIMATION.current_animation == "JumpEnd":
		await ANIMATION.animation_finished
	else:
		ANIMATION.play("walking", -1.0,1.0)
	
	
func exit() -> void:
	ANIMATION.speed_scale = 1.0

func update(delta):
	CONTROLLER.update_gravity(delta)
	CONTROLLER.update_input(SPEED,ACCELERATION,DECELERATION)
	CONTROLLER.update_velocity()
	
	set_animation_speed(CONTROLLER.velocity.length())
	
	#state changes
	if Input.is_action_just_pressed("sprint") and CONTROLLER.is_on_floor():
		transition.emit("stateSprint")
		
	if Input.is_action_pressed("crouch") and CONTROLLER.is_on_floor():
		transition.emit("stateCrouch")
	
	if Input.is_action_just_pressed("jump") and CONTROLLER.is_on_floor():
		transition.emit("stateJump")
		
	if CONTROLLER.velocity.length() == 0.0:
		transition.emit("stateIdle")
		
	if CONTROLLER.velocity.y < -3.0 and !CONTROLLER.is_on_floor():
		transition.emit("stateFall")
		
func set_animation_speed(spd):
	var alpha = remap(spd, 0.0, SPEED, 0.0, 1.0 )
	ANIMATION.speed_scale = lerp(0.0, TOP_ANIMATION_SPEED, alpha)
	
