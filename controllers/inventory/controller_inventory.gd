class_name ControllerInventory extends Node

@export var inventory : Inventory

var currentIndex : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for slots in inventory.slots:
		inventory.items.push_back(null)
	UiController.gInventory.emit_signal("setInventory", inventory.items)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func cycle_forward():
	if currentIndex >= inventory.slots:
		currentIndex = 0
	else: 
		currentIndex += 1
	print(currentIndex)

func cycle_backward():
	if currentIndex <= 0:
		currentIndex = inventory.slots
	else: 
		currentIndex -= 1
	print(currentIndex)

func add_to_inventory(item: Item):
	if item.inventory:
		inventory.items.insert(currentIndex, item)
		
func remove_from_inventory():
	if inventory.items[currentIndex] :
		inventory.items.remove_at(currentIndex)
		inventory.items.insert(currentIndex, null)
		
	
