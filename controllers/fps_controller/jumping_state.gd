class_name JumpingState
extends PlayerMovementState

@export var SPEED: float = 6.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.25
@export var JUMP_VELOCITY: float = 4.5
@export_range(0.5,1.0,0.1) var INPUT_MULIPTLIER: float = 0.85

func enter() -> void:
	PLAYER.velocity.y += JUMP_VELOCITY
	ANIMATION.play("JumpStart")
	
func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED * INPUT_MULIPTLIER, ACCELERATION,DECELERATION)
	PLAYER.update_velocity()
	
	if Input.is_action_just_released("jump"):
		if PLAYER.velocity.y > 0:
			PLAYER.velocity.y = PLAYER.velocity.y / 2.0
	
	if PLAYER.is_on_floor():
		ANIMATION.play("JumpEnd")
		if ANIMATION.is_playing() and ANIMATION.current_animation == "JumpEnd":
			await ANIMATION.animation_finished
		if Input.is_action_pressed("sprint"):
			transition.emit("SprintingState")
		elif Input.is_action_pressed("move_forward"):
			transition.emit("WalkingState")
		else:
			transition.emit("IdleState")
	
		
