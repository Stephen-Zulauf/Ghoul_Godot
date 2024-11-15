class_name InteractionComponent extends Node3D

@export var resource : Item

var overlay = preload("res://resources/Items/item_overlay_material_3d.tres")
#var parent
var child : ItemScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	instancing()
	for c in get_children():
		if c is ItemScene: 
			child = c
	connect_signals()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func instancing():
	if resource:
		var instance = resource.scene.instantiate()
		add_child(instance)
	
	
func on_focus() -> void:
	#print("focused: " + parent.name)
	if child.scene_mesh:
		child.scene_mesh.material_overlay = overlay
	UiController.gInteraction.emit_signal("focused", resource.new_icon, resource.override_icon, resource.context)
	

func on_unfocus() -> void:
	#print("un-focused: " + parent.name)
	if child.scene_mesh:
		child.scene_mesh.material_overlay = null
	UiController.gInteraction.emit_signal("unfocused")

func on_interact() -> void:
	#print("picked: " + parent.name)
	if child.scene_mesh:
		child.scene_mesh.material_overlay = null
	UiController.gInteraction.emit_signal("unfocused")
	UiController.gInteraction.emit_signal("interacted")

func on_uninteract() -> void:
	pass
	
func get_resource() -> Item:
	return resource

func connect_signals() -> void:
	child.add_user_signal("focused")
	child.add_user_signal("unfocused")
	child.add_user_signal("interacted")
	child.add_user_signal("uninteracted")
	
	child.connect("focused", Callable(self, "on_focus"))
	child.connect("unfocused", Callable(self, "on_unfocus"))
	child.connect("interacted", Callable(self, "on_interact"))
	child.connect("uninteracted", Callable(self, "on_uninteract"))
	
