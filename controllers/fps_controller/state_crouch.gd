class_name StateCrouch extends State

@export var SPEED: float = 3.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.25
@export_range(1,6,0.1) var CROUCH_SPEED: float = 4.0

@export var ANIMATION: AnimationPlayer
@export var CONTROLLER: Controller
@export var CROUCH_SHAPECAST: ShapeCast3D

#@onready var CROUCH_SHAPECAST: ShapeCast3D = PLAYER.CROUCH_SHAPECAST

func enter() -> void:
	ANIMATION.play("crouch", -1.0, CROUCH_SPEED)
	
func update(delta):
	CONTROLLER.update_gravity(delta)
	CONTROLLER.update_input(SPEED, ACCELERATION, DECELERATION)
	CONTROLLER.update_velocity()
	
	if Input.is_action_just_released("crouch"):
		uncrouch()
		
func uncrouch():
	if CROUCH_SHAPECAST.is_colliding() == false and Input.is_action_pressed("crouch") == false:
		ANIMATION.play("crouch", -1.0, -CROUCH_SPEED * 1.5, true)
		if ANIMATION.is_playing():
			await ANIMATION.animation_finished
		transition.emit("stateIdle")
	elif CROUCH_SHAPECAST.is_colliding() == true:
		await get_tree().create_timer(0.1).timeout
		uncrouch()
