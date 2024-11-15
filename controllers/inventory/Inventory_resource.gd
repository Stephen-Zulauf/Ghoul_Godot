class_name Inventory extends Resource

# Universal
@export_category("General")
@export var name: StringName

# Storage
@export_category("Storage")
@export var slots : int = 4

@export var items : Array[Item]
