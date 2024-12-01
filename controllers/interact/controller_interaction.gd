class_name InteractRig extends Node3D

@export var HAND_LENGTH : float = 2.0
@export var RAY_LENGTH : float = 2.0
@export var HAND: Marker3D
@export var HAND_BODY: StaticBody3D
@export var JOINT: Generic6DOFJoint3D
@export var PULL: float = 5.0
@export var ROTATION: float = 0.05
@export var THROW_STRENGTH: float = 5
@export var CAMERA : Camera3D

var currentFocus
var lastFocus

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HAND.global_position.z -= HAND_LENGTH
	HAND_BODY.global_position.z -= HAND_LENGTH

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	interaction_cast()
	
func interaction_cast() -> void:
	var space_state = CAMERA.get_world_3d().direct_space_state
	var screen_center = get_viewport().get_mouse_position()
	var origin = CAMERA.project_ray_origin(screen_center)
	var end = origin + CAMERA.project_ray_normal(screen_center) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_bodies = true
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
	currentFocus = result.get("collider")
