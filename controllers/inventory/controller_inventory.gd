class_name ControllerInventory extends Node

@export var inventory : Inventory
@export var heldRig : HeldRig

var currentIndex : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for slots in inventory.slots:
		inventory.items.push_back(null)
	UiController.gInventory.emit_signal("setInventory", inventory.items)
	UiController.gInventory.emit_signal("focused", currentIndex)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("inv_forward"):
		cycle_forward()
	if Input.is_action_just_pressed("inv_backwards"):
		cycle_backward()
	if Input.is_action_just_pressed("inventory_show"):
		UiController.gInventory.emit_signal("hide")

func cycle_forward():
	if currentIndex >= inventory.slots-1:
		currentIndex = 0
	else: 
		currentIndex += 1
	UiController.gInventory.emit_signal("focused", currentIndex)
	if inventory.items[currentIndex]:
		heldRig.ITEM = inventory.items[currentIndex]
		heldRig.load_item()
	#print(currentIndex)

func cycle_backward():
	if currentIndex <= 0:
		currentIndex = inventory.slots - 1
	else: 
		currentIndex -= 1
	UiController.gInventory.emit_signal("focused", currentIndex)
	if inventory.items[currentIndex]:
		heldRig.ITEM = inventory.items[currentIndex]
		heldRig.load_item()
	#print(currentIndex)

func add_to_inventory(item: Item):
	if item.inventory:
		inventory.items.insert(currentIndex, item)
		UiController.gInventory.emit_signal("setInventory", inventory.items)
		heldRig.ITEM = inventory.items[currentIndex]
		heldRig.load_item()
		
func remove_from_inventory():
	if inventory.items[currentIndex] :
		var new_node = InteractionComponent.new()
		new_node.resource = inventory.items[currentIndex]
		new_node.position = heldRig.global_position
		var grid = get_parent().get_parent()
		print("adding: " + new_node.resource.context)
		grid.add_child(new_node)

		inventory.items.remove_at(currentIndex)
		inventory.items.insert(currentIndex, null)
		UiController.gInventory.emit_signal("setInventory", inventory.items)
		heldRig.ITEM = inventory.items[currentIndex]
		heldRig.load_item()
		
	
