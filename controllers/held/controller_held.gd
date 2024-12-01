@tool

class_name HeldRig extends Node3D

@export var ITEM : Item:
	set(value):
		ITEM = value
		if Engine.is_editor_hint():
			load_item()

@onready var held_mesh : MeshInstance3D = %ItemMesh

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_item()

#TODO update_hand_weapon
func load_item() -> void:
	if ITEM:
		held_mesh.mesh = ITEM.mesh #set weapon mesh
		position = ITEM.position #set weapon postion
		rotation_degrees = ITEM.rotation # set rotation
		scale = ITEM.scale # set scale
	else:
		held_mesh.mesh = null

#func _physics_process(_delta: float) -> void:
	#pass
	
