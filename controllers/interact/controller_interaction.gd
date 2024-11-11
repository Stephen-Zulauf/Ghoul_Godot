class_name ControllerInteraction extends Node3D

@export var RAY: RayCast3D
@export var HAND_LENGTH : float = 2.0
@export var HAND: Marker3D
@export var HAND_BODY: StaticBody3D
@export var JOINT: Generic6DOFJoint3D
@export var PULL: float = 4.0
@export var ROTATION: float = 0.05
@export var THROW_STRENGTH: float = 5

var picked_object : Pickable
var collider
var locked : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HAND.global_position.z -= HAND_LENGTH
	HAND_BODY.global_position.z -= HAND_LENGTH

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if picked_object != null:
		#HAND_BODY.translate(RAY.get_collision_point())
	if Input.is_action_just_pressed("interact"):
		pick_object()

func _input(event: InputEvent) -> void:
	pass

func pick_object():
	collider = RAY.get_collider()
	if collider != null and collider is Pickable:
		picked_object = collider
		

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("interact") and picked_object != null:
		JOINT.set_node_b(picked_object.get_path())
		var a = picked_object.global_transform.origin
		var b = HAND.global_transform.origin
		#var b = RAY.get_collision_point()
		picked_object.set_linear_velocity((b-a)*PULL)
		
		if Input.is_action_just_pressed("throw") and picked_object != null:
			var knockback = picked_object.global_position - get_parent().global_position
			picked_object.apply_central_impulse(knockback*THROW_STRENGTH)
			picked_object = null
			JOINT.set_node_b(JOINT.get_path())
	if Input.is_action_just_released("interact"):
		JOINT.set_node_b(JOINT.get_path())
