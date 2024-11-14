class_name InteractionComponent extends Node

@export var MESH : MeshInstance3D
@export var context : String
@export var override_icon : bool
@export var new_icon : Texture2D

var overlay = preload("res://resources/Item/item_overlay_material_3d.tres")
var parent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	connect_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func on_focus() -> void:
	#print("focused: " + parent.name)
	if MESH:
		MESH.material_overlay = overlay
	UiController.gInteraction.emit_signal("focused", new_icon, override_icon, context)
	

func on_unfocus() -> void:
	#print("un-focused: " + parent.name)
	if MESH:
		MESH.material_overlay = null
	UiController.gInteraction.emit_signal("unfocused")

func on_interact() -> void:
	#print("picked: " + parent.name)
	if MESH:
		MESH.material_overlay = null
	UiController.gInteraction.emit_signal("unfocused")
	UiController.gInteraction.emit_signal("interacted")

func on_uninteract() -> void:
	pass
	#print("dropped: " + parent.name)
	#UiController.Interaction.emit_signal("focused", new_icon, override_icon, context)

func connect_parent() -> void:
	parent.add_user_signal("focused")
	parent.add_user_signal("unfocused")
	parent.add_user_signal("interacted")
	parent.add_user_signal("uninteracted")
	parent.connect("focused", Callable(self, "on_focus"))
	parent.connect("unfocused", Callable(self, "on_unfocus"))
	parent.connect("interacted", Callable(self, "on_interact"))
	parent.connect("uninteracted", Callable(self, "on_uninteract"))
