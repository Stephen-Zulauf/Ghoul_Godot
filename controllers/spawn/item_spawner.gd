class_name ItemSpawner
extends Node3D

@export var Items: Array[Item]

var rng = RandomNumberGenerator.new()

var current_item: Item

func loadRandomItem() -> void:
	var address = rng.randi_range(0,Items.size()-1)
	var res: Item = Items[address]
	current_item = res

func instance() -> void:
	var newInstance = current_item.Scene.instantiate()
	add_child(newInstance)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loadRandomItem()
	instance()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
