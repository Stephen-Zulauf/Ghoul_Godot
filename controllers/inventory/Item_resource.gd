class_name Item extends Resource

# Universal
@export_category("General")
@export var name: StringName
@export var mesh : Mesh
@export var icon : Texture2D
@export var scene : PackedScene
@export var shadow: bool


@export_category("Typing")
@export var pickable : bool
@export var inventory : bool
@export var weapon : bool

@export_category("stats")
@export var value : int
@export var base_damage : float

# Inventory specific
# Weapon specific

# FPS View Information
@export_category("FPS View Orientation")
@export var position : Vector3
@export var rotation: Vector3

@export_category("FPS View Scale")
@export var scale: Vector3 = Vector3(1,1,1)

@export_category("FPS View Sway")
@export var sway_min : Vector2 = Vector2(-20.0,-20.0)
@export var sway_max : Vector2 = Vector2(20.0, 20.0)
@export_range(0,0.2,0.1) var sway_speed_position : float = 0.07
@export_range(0,0.2,0.1) var sway_speed_rotation : float = 0.1
@export_range(0,0.25,0.01) var sway_amount_position : float = 0.1
@export_range(0,50,0.1) var sway_amount_rotation : float = 30.0

@export_category("FPS View Idle Sway")
@export var idle_sway : float = 10.0
@export var idle_sway_rotation : float = 300.0
@export_range(0.1,10.0,0.1) var random_sway_amount : float = 5.0


 
