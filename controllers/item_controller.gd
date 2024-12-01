class_name ItemController extends Node


@export var heldRig : HeldRig
@export var interactRig : InteractRig
@export var inventoryRig : InventoryRig
var parent : CharacterBody3D

var current_focus
var last_focus

var picked_object
var current_index = 0

var added_to_inventory : bool = false # check if picked was added to inv this frame

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	init_inventory()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	get_focus() # get result of raycast
	pick_object() # select object if intractive component
	
	#inventory functions first
	add_to_inventory() # if take pressed then add to inventory
	remove_from_inventory() # if take pressed and not added this fram then drop item from inventory
	cycle_forward() # cycle inventory selection forward
	cycle_backward() # cycle inventory selection backwards
	
	#interaction functions second
	pickup_object() # if interaction is held pickup object
	throw_object() # throw object if interaction and throw
	drop_object() # if interaction is released drop object
	
	
	change_focus()
	
	
#### Interaction Functions

func get_focus() -> void:
	added_to_inventory = false
	current_focus = interactRig.currentFocus

func change_focus() -> void:
	if !Input.is_action_pressed("interact"):
		if last_focus != current_focus:
			last_focus = current_focus
			un_pick_object()

func pick_object() -> void:
	if !Input.is_action_pressed("interact"):
		if current_focus != null and current_focus.has_user_signal("focused"):
			picked_object = current_focus
			picked_object.emit_signal("focused")
			#print(current_focus)

func un_pick_object() -> void:
	if !Input.is_action_pressed("interact"):
		if picked_object != null and picked_object.has_user_signal("unfocused"):
			picked_object.emit_signal("unfocused")
			picked_object = null
		
func pickup_object() -> void:
	if Input.is_action_pressed("interact") and picked_object != null:
		interactRig.JOINT.set_node_b(picked_object.get_path())
		var a = picked_object.global_transform.origin
		var b = interactRig.HAND.global_transform.origin
		picked_object.set_linear_velocity((b-a) * interactRig.PULL)
		
func drop_object() -> void:
	#reset when interaction key is let go
	if Input.is_action_just_released("interact"):
		interactRig.JOINT.set_node_b(interactRig.JOINT.get_path())
		un_pick_object()

func throw_object() -> void:
	#throw the object if held
	if Input.is_action_pressed("interact") and Input.is_action_just_pressed("throw") and picked_object != null:
		var knockback = picked_object.global_position - get_parent().global_position
		picked_object.apply_central_impulse(knockback* interactRig.THROW_STRENGTH)
		interactRig.JOINT.set_node_b(interactRig.JOINT.get_path())
		picked_object.emit_signal("unfocused")
		picked_object = null


#### Inventory Functions

func init_inventory() -> void:
	for slots in inventoryRig.inventory.slots:
		inventoryRig.inventory.items.push_back(null)
	UiController.gInventory.emit_signal("setInventory", inventoryRig.inventory.items)
	UiController.gInventory.emit_signal("focused", current_index)

func add_to_inventory() -> void:
	# add to inventory
	if Input.is_action_just_pressed("take") and picked_object != null and current_focus.get_parent() is InteractionComponent:
		var focus : InteractionComponent = current_focus.get_parent()
		
		if inventoryRig.inventory:
			#insert into inventory
			inventoryRig.inventory.items.insert(current_index, focus.resource)
			#tell UI to reload invetory display
			UiController.gInventory.emit_signal("setInventory", inventoryRig.inventory.items)
			#tell holding rig to load new item
			heldRig.ITEM = inventoryRig.inventory.items[current_index]
			heldRig.load_item()
			
			#free 3d scene from map
			focus.queue_free()
			await focus.tree_exited
			current_focus = null
			
			added_to_inventory = true
			un_pick_object()

func remove_from_inventory() -> void:
	if Input.is_action_just_pressed("take") and !picked_object and !added_to_inventory:
		
		#drop item
		if inventoryRig.inventory.items[current_index]:
			var new_node = InteractionComponent.new()
			new_node.resource = inventoryRig.inventory.items[current_index]
			var spawn: Vector3
			spawn = interactRig.HAND.global_transform.origin
			new_node.position = spawn
			var grid = parent.get_parent()
			print("adding: " + new_node.resource.context)
			grid.add_child(new_node)
			
		#remove from inventory
		inventoryRig.inventory.items.remove_at(current_index)
		inventoryRig.inventory.items.insert(current_index, null)
		UiController.gInventory.emit_signal("setInventory", inventoryRig.inventory.items)
		heldRig.ITEM = inventoryRig.inventory.items[current_index]
		heldRig.load_item()
		un_pick_object()

func cycle_forward():
	if Input.is_action_just_pressed("inv_forward"):
		if current_index >= inventoryRig.inventory.slots-1:
			current_index = 0
		else: 
			current_index += 1
		
		UiController.gInventory.emit_signal("focused", current_index)
		heldRig.ITEM = inventoryRig.inventory.items[current_index]
		heldRig.load_item()
			
	

func cycle_backward():
	if Input.is_action_just_pressed("inv_backwards"):
		if current_index <= 0:
			current_index = inventoryRig.inventory.slots - 1
		else: 
			current_index -= 1
	
		UiController.gInventory.emit_signal("focused", current_index)
		heldRig.ITEM = inventoryRig.inventory.items[current_index]
		heldRig.load_item()
