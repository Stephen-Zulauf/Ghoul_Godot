@tool

extends Node3D

@export var WEAPON_TYPE : Weapons:
	set(value):
		WEAPON_TYPE = value
		if Engine.is_editor_hint():
			load_weapon()

@onready var weapon_mesh : MeshInstance3D = $WeaponMesh
@onready var weapon_shadow : MeshInstance3D = $WeaponShadow

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_weapon()
	
func _input(event):
	if event.is_action_pressed("temp_weapon1"):
		WEAPON_TYPE = load("res://weapons/crowbar/crowbarL_res.tres")
		load_weapon()
	if event.is_action_pressed("temp_weapon2"):
		WEAPON_TYPE = load("res://weapons/crowbar/crowbarR_res.tres")
		load_weapon()

func load_weapon() -> void:
	weapon_mesh.mesh = WEAPON_TYPE.mesh #set weapon mesh
	set_position(WEAPON_TYPE.postion) #set weapon postion
	rotation_degrees = WEAPON_TYPE.rotation # set rotation
	weapon_shadow.visible = WEAPON_TYPE.shadow
	scale = WEAPON_TYPE.scale
