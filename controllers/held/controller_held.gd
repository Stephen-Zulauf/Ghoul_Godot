@tool

class_name ControllerHeld extends Node3D

@export var ITEM : Item:
	set(value):
		ITEM = value
		if Engine.is_editor_hint():
			load_item()
@export var sway_noise : NoiseTexture2D
@export var sway_speed : float = 1.2
@export var reset : bool = false:
	set(value):
		reset = value
		if Engine.is_editor_hint():
			load_item()

#@onready var item_mesh : MeshInstance3D = %ItemMesh
#@onready var weapon_shadow : MeshInstance3D = $WeaponShadow

@onready var item_mesh : MeshInstance3D = %ItemMesh

var mouse_movement : Vector2
var random_sway_x
var random_sway_y
var random_sway_amount : float
var time : float = 0.0
var idle_sway_adjustment
var idle_sway_rotation_strength

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_item()
	
func _input(event):
	#if event.is_action_pressed("temp_weapon1"):
		#WEAPON_TYPE = load("res://resources/Weapons/crowbar/crowbarL_res.tres")
		#load_weapon()
	#if event.is_action_pressed("temp_weapon2"):
		#WEAPON_TYPE = load("res://resources/Weapons/crowbar/crowbarR_res.tres")
		#load_weapon()
	if event is InputEventMouseMotion:
		mouse_movement = event.relative

#TODO update_hand_weapon
func load_item() -> void:
	item_mesh.mesh = ITEM.mesh #set weapon mesh
	position = ITEM.position #set weapon postion
	rotation_degrees = ITEM.rotation # set rotation
	scale = ITEM.scale # set scale
	
	#item_shadow.visible = ITEM.shadow
	
	#idle vars
	idle_sway_adjustment = ITEM.idle_sway
	idle_sway_rotation_strength = ITEM.idle_sway_rotation
	random_sway_amount = ITEM.random_sway_amount
	
func update_sway(delta) -> void:
	#clamp
	mouse_movement = mouse_movement.clamp(ITEM.sway_min, ITEM.sway_max)
	#lerp postions based on mouse
	
	position.x = lerp(position.x, ITEM.position.x - (mouse_movement.x * ITEM.sway_amount_position) * delta, ITEM.sway_speed_position)
	position.y = lerp(position.y, ITEM.position.y - (mouse_movement.y * ITEM.sway_amount_position) * delta, ITEM.sway_speed_position)
	
	#lerp rotation
	rotation_degrees.y = lerp(rotation_degrees.y, ITEM.rotation.y + (mouse_movement.x * ITEM.sway_amount_rotation) * delta, ITEM.sway_speed_rotation)
	rotation_degrees.x = lerp(rotation_degrees.x, ITEM.rotation.x + (mouse_movement.y * ITEM.sway_amount_rotation) * delta, ITEM.sway_speed_rotation)
func update_idle(_delta) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass
	#update_sway(delta)
