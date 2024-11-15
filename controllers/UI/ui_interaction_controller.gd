class_name UIInteractionController extends CanvasLayer

@export var icon : TextureRect
@export var context : Label
@export var default_icon : Texture2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UiController.gInteraction = self
	self.add_user_signal("focused")
	self.add_user_signal("unfocused")
	self.add_user_signal("interacted")
	#self.add_user_signal("uninteracted")
	self.connect("focused", Callable(self, "on_focus"))
	self.connect("unfocused", Callable(self, "on_unfocus"))
	self.connect("interacted", Callable(self, "on_interact"))
	#self.connect("uninteracted", Callable(self, "on_uninteract"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
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
	

	
	
	
