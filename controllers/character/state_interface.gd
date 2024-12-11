class_name StateInterface
extends Node3D

@onready var CHART = $"../StateChart"
@onready var CONTROLLER = $".."
@onready var SPRING_ARM = $"../X Bot/GeneralSkeleton/BoneAttachment3D/SpringArmPivot/SpringArm3D"
@export var SPRING_ARM_LENGTH: float = 3.0
#@export var CONTROLLER: CharacterController

@onready var ANIM_TREE: AnimationTree = $"../AnimationTree2"
#@onready var ANIM_PLAYBACK: AnimationNodeStateMachinePlayback = ANIM_TREE.get(parameters/playback)
#movement variables
@export var SPEED: float = 2.5
@export var ACCELERATION: float = 1.5
@export var DECELERATION: float = 0.5
@export var JUMP_VELOCITY: float = 4.5

var run_speed: float = 5.0
var run_acc: float = 0.9

var walk_speed: float = 3.0
var walk_acc: float = 1.5

var crouch_speed: float = 2.5
var crouch_acc: float = 0.8

var def_acc: float = 1.5
var def_dec: float = 0.5



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	CONTROLLER.update_gravity(delta)
	CONTROLLER.update_input(SPEED,ACCELERATION,DECELERATION)
	CONTROLLER.update_velocity()
	
	SPRING_ARM.set("spring_length", SPRING_ARM_LENGTH)
	

#check if grounded or in air
func _on_grounded_state_physics_processing(delta: float) -> void:
	#if jump is held then go to jump
	if Input.is_action_just_pressed("jump"):
		CONTROLLER.velocity.y += JUMP_VELOCITY
		CHART.send_event("air")
	elif !CONTROLLER.is_on_floor():
		CHART.send_event("air")
	if Input.is_action_just_pressed("camera"):
		if SPRING_ARM_LENGTH > 0:
			SPRING_ARM_LENGTH = 0
		else: 
			SPRING_ARM_LENGTH = 3

func _on_inair_state_physics_processing(delta: float) -> void:
	if CONTROLLER.is_on_floor():
		CHART.send_event("land")
	elif CONTROLLER.velocity.y < 0:
		CHART.send_event("fall")

#on entering states methods
func _on_idle_state_entered() -> void:
	SPEED = walk_speed
	ACCELERATION = walk_acc
	var playback = ANIM_TREE.get("parameters/movement anims/playback")
	playback.travel("idle")

func _on_walking_state_entered() -> void:
	SPEED = walk_speed
	ACCELERATION = walk_acc
	var playback = ANIM_TREE.get("parameters/movement anims/playback")
	playback.travel("walk")

func _on_sprinting_state_entered() -> void:
	SPEED = run_speed
	ACCELERATION = run_acc
	var playback = ANIM_TREE.get("parameters/movement anims/playback")
	playback.travel("run")

func _on_crouching_state_entered() -> void:
	SPEED = crouch_speed
	ACCELERATION = crouch_acc
	var playback = ANIM_TREE.get("parameters/movement anims/playback")
	playback.travel("crouch")

func _on_jump_state_entered() -> void:
	var playback = ANIM_TREE.get("parameters/movement anims/playback")
	playback.travel("jump")

func _on_fall_state_entered() -> void:
	var playback = ANIM_TREE.get("parameters/movement anims/playback")
	playback.travel("fall")

#on state functions
func _on_idle_state_physics_processing(delta: float) -> void:
	if Input.is_action_pressed("sprint"):
		CHART.send_event("sprint")
	elif Input.is_action_just_pressed("crouch"):
		CHART.send_event("crouch")
	elif CONTROLLER.velocity.length() > 0:
		CHART.send_event("walk")

func _on_walking_state_physics_processing(delta: float) -> void:
	var rel_vel = CONTROLLER.global_basis.inverse() * ((CONTROLLER.velocity * Vector3(1,0,1))/SPEED)
	var rel_vel_xz = Vector2(rel_vel.x, -rel_vel.z)
	ANIM_TREE.set("parameters/movement anims/walk/blend_position", rel_vel_xz)
	if Input.is_action_pressed("sprint"):
		CHART.send_event("sprint")
	elif Input.is_action_just_pressed("crouch"):
		CHART.send_event("crouch")
	else:
		if CONTROLLER.velocity.length() == 0:
			CHART.send_event("idle")

func _on_sprinting_state_physics_processing(delta: float) -> void:
	var rel_vel = CONTROLLER.global_basis.inverse() * ((CONTROLLER.velocity * Vector3(1,0,1))/SPEED)
	var rel_vel_xz = Vector2(rel_vel.x, -rel_vel.z)
	ANIM_TREE.set("parameters/movement anims/run/blend_position", rel_vel_xz)
	if Input.is_action_just_released("sprint"):
		if CONTROLLER.velocity.length() == 0:
			CHART.send_event("idle")
		else:
			CHART.send_event("walk")
	if Input.is_action_just_pressed("crouch"):
		CHART.send_event("crouch")

func _on_crouching_state_physics_processing(delta: float) -> void:
	var rel_vel = CONTROLLER.global_basis.inverse() * ((CONTROLLER.velocity * Vector3(1,0,1))/SPEED)
	var rel_vel_xz = Vector2(rel_vel.x, -rel_vel.z)
	ANIM_TREE.set("parameters/movement anims/crouch/blend_position", rel_vel_xz)

	if Input.is_action_pressed("sprint"):
		CHART.send_event("sprint")
	elif Input.is_action_just_released("crouch"):
		if CONTROLLER.velocity.length() == 0:
			CHART.send_event("idle")
		else:
			CHART.send_event("walk")
