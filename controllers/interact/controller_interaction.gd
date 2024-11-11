class_name ControllerInteraction extends Node3D

@export var RAY: RayCast3D
@export var HAND: Marker3D
@export var PULL: float = 4.0

var picked_object : Pickable
var collider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pick_object()

func _input(event: InputEvent) -> void:
	pass

func pick_object():
	collider = RAY.get_collider()
	if collider != null and collider is Pickable:
		picked_object = collider

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("interact"):
		var a = picked_object.global_transform.origin
		var b = HAND.global_transform.origin
		picked_object.set_linear_velocity((b-a)*PULL)
	
