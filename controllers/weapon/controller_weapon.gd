@tool

class_name ControllerWeapon extends Node3D

@export var WEAPON_TYPE : Weapons:
	set(value):
		WEAPON_TYPE = value
		if Engine.is_editor_hint():
			load_weapon()
@export var sway_noise : NoiseTexture2D
@export var sway_speed : float = 1.2
@export var reset : bool = false:
	set(value):
		reset = value
		if Engine.is_editor_hint():
			load_weapon()

@onready var weapon_mesh : MeshInstance3D = $WeaponMesh
@onready var weapon_shadow : MeshInstance3D = $WeaponShadow

var mouse_movement : Vector2
var random_sway_x
var random_sway_y
var random_sway_amount : float
var time : float = 0.0
var idle_sway_adjustment
var idle_sway_rotation_strength

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_weapon()
	
func _input(event):
	if event.is_action_pressed("temp_weapon1"):
		WEAPON_TYPE = load("res://resources/Weapons/crowbar/crowbarL_res.tres")
		load_weapon()
	if event.is_action_pressed("temp_weapon2"):
		WEAPON_TYPE = load("res://resources/Weapons/crowbar/crowbarR_res.tres")
		load_weapon()
	if event is InputEventMouseMotion:
		mouse_movement = event.relative

#TODO update_hand_weapon
func load_weapon() -> void:
	weapon_mesh.mesh = WEAPON_TYPE.mesh #set weapon mesh
	position = WEAPON_TYPE.position #set weapon postion
	rotation_degrees = WEAPON_TYPE.rotation # set rotation
	scale = WEAPON_TYPE.scale # set scale
	
	weapon_shadow.visible = WEAPON_TYPE.shadow
	
	#idle vars
	idle_sway_adjustment = WEAPON_TYPE.idle_sway
	idle_sway_rotation_strength = WEAPON_TYPE.idle_sway_rotation
	random_sway_amount = WEAPON_TYPE.random_sway_amount
	
func update_sway(delta) -> void:
	#clamp
	mouse_movement = mouse_movement.clamp(WEAPON_TYPE.sway_min, WEAPON_TYPE.sway_max)
	#lerp postions based on mouse
	
	position.x = lerp(position.x, WEAPON_TYPE.position.x - (mouse_movement.x * WEAPON_TYPE.sway_amount_position) * delta, WEAPON_TYPE.sway_speed_position)
	position.y = lerp(position.y, WEAPON_TYPE.position.y - (mouse_movement.y * WEAPON_TYPE.sway_amount_position) * delta, WEAPON_TYPE.sway_speed_position)
	
	#lerp rotation
	rotation_degrees.y = lerp(rotation_degrees.y, WEAPON_TYPE.rotation.y + (mouse_movement.x * WEAPON_TYPE.sway_amount_rotation) * delta, WEAPON_TYPE.sway_speed_rotation)
	rotation_degrees.x = lerp(rotation_degrees.x, WEAPON_TYPE.rotation.x + (mouse_movement.y * WEAPON_TYPE.sway_amount_rotation) * delta, WEAPON_TYPE.sway_speed_rotation)
func update_idle(_delta) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass
	#update_sway(delta)
