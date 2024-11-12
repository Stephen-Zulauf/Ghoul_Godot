class_name ControllerInteraction extends Node3D

@export var RAY: RayCast3D
@export var HAND_LENGTH : float = 4.0
@export var HAND: Marker3D
@export var HAND_BODY: StaticBody3D
@export var JOINT: Generic6DOFJoint3D
@export var PULL: float = 4.0
@export var ROTATION: float = 0.05
@export var THROW_STRENGTH: float = 5
@export var OVERLAY : StandardMaterial3D
@export var CAMERA : Camera3D

var picked_object : Pickable
var currentFocus
var lastFocus
var locked : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HAND.global_position.z -= HAND_LENGTH
	HAND_BODY.global_position.z -= HAND_LENGTH

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	#get collision
	#currentFocus = RAY.get_collider()
	interaction_cast()
	
	#send current colsion object to debug panel
	Debug.fpsControllerDebugPanel.add_property(RAY.name, currentFocus, 1)
	
	#check for focus and unfocus from last frame
	if lastFocus != currentFocus:
		if lastFocus and lastFocus.has_user_signal("unfocused"):
			lastFocus.emit_signal("unfocused")
		lastFocus = currentFocus 
		if currentFocus and currentFocus.has_user_signal("focused"):
			currentFocus.emit_signal("focused")
	
				
	#check for interaction input
	if Input.is_action_just_pressed("interact"):
		pick_object(currentFocus)
		
	if Input.is_action_just_released("interact"):
		un_pick_object()
			

func pick_object(collider) -> bool:
	#collider = currentFocus
	if collider != null and collider.has_user_signal("interacted"):
		picked_object = collider
		picked_object.emit_signal("interacted")
		return true
	else:
		return false

func un_pick_object() -> bool:
	if picked_object != null and picked_object.has_user_signal("uninteracted"):
		picked_object.emit_signal("uninteracted")
		picked_object = null
		return true
	else:
		return false
		
func interaction_cast() -> void:
	var space_state = CAMERA.get_world_3d().direct_space_state
	var screen_center = get_viewport().get_mouse_position()
	var origin = CAMERA.project_ray_origin(screen_center)
	var end = origin + CAMERA.project_ray_normal(screen_center) * HAND_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_bodies = true
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
	currentFocus = result.get("collider")
	
func _physics_process(_delta: float) -> void:
	pass
	# add to inventory
	#if Input.is_action_just_pressed("take") and picked_object is Item and picked_object != null:
		##TODO add to inventory if room
		#print("added to inventory")
		#picked_object.queue_free()
		#picked_object = null
	## pull object towards player
	#if Input.is_action_pressed("interact") and picked_object != null:
		#JOINT.set_node_b(picked_object.get_path())
		#var a = picked_object.global_transform.origin
		#var b = HAND.global_transform.origin
		##var b = RAY.get_collision_point()
		#picked_object.set_linear_velocity((b-a)*PULL)
		#
		##throw the object if held
		#if Input.is_action_just_pressed("throw") and picked_object != null:
			#var knockback = picked_object.global_position - get_parent().global_position
			#for child in picked_object.get_children():
				#if child is MeshInstance3D:
					#child.material_overlay = null
			#picked_object.apply_central_impulse(knockback*THROW_STRENGTH)
			#picked_object = null
			#JOINT.set_node_b(JOINT.get_path())
	##reset when interaction key is let go
	#if Input.is_action_just_released("interact"):
		#for child in picked_object.get_children():
			#if child is MeshInstance3D:
				#child.material_overlay = null
		#JOINT.set_node_b(JOINT.get_path())
