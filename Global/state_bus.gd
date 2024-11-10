class_name StateBus extends Node

var StateMachineCurrent : Dictionary
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is StateMachine:
			StateMachineCurrent[child.get_name()] = child.CURRENT_STATE 
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for child in get_children():
		if child is StateMachine:
			StateMachineCurrent[child.get_name()] = child.CURRENT_STATE 
		Debug.fpsControllerDebugPanel.add_property(child.get_name(), child.CURRENT_STATE.name, 1)
	
