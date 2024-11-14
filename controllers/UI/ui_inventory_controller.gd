class_name UIInventoryController extends CanvasLayer

@export var icon : TextureRect
@export var context : Label
@export var default_icon : Texture2D

@export var container : HBoxContainer
@export var slot0 : TextureRect
@export var slot1 : TextureRect
@export var slot2 : TextureRect
@export var slot3 : TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UiController.gInventory = self
	self.add_user_signal("focused")
	self.add_user_signal("unfocused")
	self.add_user_signal("interacted")
	self.add_user_signal("setInventory")
	#self.add_user_signal("uninteracted")
	self.connect("focused", Callable(self, "on_focus"))
	self.connect("unfocused", Callable(self, "on_unfocus"))
	self.connect("interacted", Callable(self, "on_interact"))
	self.connect("setInventory", Callable(self, "set_inventory"))
	#self.connect("uninteracted", Callable(self, "on_uninteract"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func reset() -> void:
	icon.texture = null
	context.text = ""

func on_interact():
	reset()
	self.visible = false

func on_focus(image: Texture2D, override: bool, text: String) -> void:
	
	if override:
		icon.texture = image
	else:
		icon.texture = default_icon
		
	context.text = text
		
	self.visible = true

func on_unfocus() -> void:
	reset()
	self.visible = false
	
func set_inventory(inventory: Array[Item]) -> void:
	if inventory[0]:
		slot0.texture = inventory[0].icon
	else: 
		slot0.texture = default_icon
	
	if inventory[1]:
		slot1.texture = inventory[1].icon
	else: 
		slot1.texture = default_icon
	
	if inventory[2]:
		slot2.texture = inventory[2].icon
	else: 
		slot2.texture = default_icon
	
	if inventory[3]:
		slot3.texture = inventory[3].icon
	else: 
		slot3.texture = default_icon
