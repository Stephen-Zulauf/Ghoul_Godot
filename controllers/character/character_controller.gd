class_name CharacterController
extends CharacterBody3D

#mouse camera movement variables
@export var MOUSE_SENSITIVITY: float = 0.5
@export var TILT_LOWER_LIMIT := deg_to_rad(-70.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(90)
@export var CAMERA_CONTROLLER : Node3D

#movement variables
@export var SPEED: float = 3.0
@export var ACCELERATION: float = 1.5
@export var DECCELERATION: float = 0.5

##animation
@export var ANIMTREE: AnimationTree

#state realted vars
@onready var StateDebugger = $StateChartDebugger

#@export var ANIMATIONPLAYER: AnimationPlayer
#@export var CROUCH_SHAPECAST: ShapeCast3D
#
##test access to gridmap
#@export var GRID : GridMap

var _mouse_input: bool = false
var _mouse_rotation: Vector3
var _rotation_input: float
var _tilt_input: float
var _player_rotation: Vector3
var _camera_rotation: Vector3


func _input(event):
	if event.is_action_pressed("exit"):
		get_tree().quit()
		
	if event.is_action_pressed("debug"):
		if StateDebugger.visible:
			StateDebugger.visible = false
		else:
			StateDebugger.visible = true

func _unhandled_input(event):
	#handle mouse movement
	#check that input is mouse motion and its captured mode
	_mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if _mouse_input:
		_rotation_input = -event.relative.x * MOUSE_SENSITIVITY
		_tilt_input = -event.relative.y * MOUSE_SENSITIVITY
		
func _update_camera(delta):
	
	#rotate camera using euler rotation
	_mouse_rotation.x += _tilt_input * delta
	_mouse_rotation.x = clamp(_mouse_rotation.x, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)
	_mouse_rotation.y += _rotation_input * delta
	
	_player_rotation = Vector3(0.0,_mouse_rotation.y,0.0)
	_camera_rotation = Vector3(_mouse_rotation.x,0.0,0.0)
	
	CAMERA_CONTROLLER.transform.basis = Basis.from_euler(_camera_rotation)
	CAMERA_CONTROLLER.rotation.z = 0;
	
	global_transform.basis = Basis.from_euler(_player_rotation)
	
	_rotation_input = 0.0
	_tilt_input = 0.0

func _ready():
	StateDebugger.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	#CROUCH_SHAPECAST.add_exception($".")

func _physics_process(delta: float) -> void:
	
	#camera mouse movement
	_update_camera(delta)

func update_gravity(delta) -> void:
	velocity += get_gravity() * delta
	
func update_input(speed: float, acceleration: float, deceleration: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = lerp(velocity.x, direction.x * speed, acceleration)
		velocity.z = lerp(velocity.z, direction.z * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)
	
func update_velocity() -> void:
	#ANIMTREE.set("parameters/idle->walk/blend_position", velocity.length()/SPEED)
	move_and_slide()
