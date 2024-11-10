class_name StateJump extends State

@export var SPEED: float = 6.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.25
@export var JUMP_VELOCITY: float = 4.5
@export_range(0.5,1.0,0.1) var INPUT_MULIPTLIER: float = 0.85

@export var ANIMATION: AnimationPlayer
@export var CONTROLLER: ControllerFPS

func enter() -> void:
	CONTROLLER.velocity.y += JUMP_VELOCITY
	ANIMATION.play("JumpStart")
	
func update(delta):
	CONTROLLER.update_gravity(delta)
	CONTROLLER.update_input(SPEED * INPUT_MULIPTLIER, ACCELERATION,DECELERATION)
	CONTROLLER.update_velocity()
	
	if Input.is_action_just_released("jump"):
		if CONTROLLER.velocity.y > 0:
			CONTROLLER.velocity.y = CONTROLLER.velocity.y / 2.0
	
	if CONTROLLER.is_on_floor():
		ANIMATION.play("JumpEnd")
		if ANIMATION.is_playing() and ANIMATION.current_animation == "JumpEnd":
			await ANIMATION.animation_finished
		if Input.is_action_pressed("sprint"):
			transition.emit("stateSprint")
		elif Input.is_action_pressed("move_forward"):
			transition.emit("stateWalk")
		else:
			transition.emit("stateIdle")
	
		
