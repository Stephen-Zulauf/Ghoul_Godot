class_name StateBus extends Node

var StateMachineCurrent : Dictionary
var Idle : bool = false
var Sprinting : bool = false
var Walking : bool = false
var Crouching : bool = false
var Jumping : bool = false
var Falling : bool = false
	
	
func clear_bools() -> void:
	Idle = false
	Sprinting = false
	Walking = false
	Crouching = false
	Jumping = false
	Falling = false
	
func matchBool(sname : String) -> void:
	match sname:
		"stateIdle":
			Idle = true
		"stateSprint":
			Sprinting = true
		"stateWalk":
			Walking = true
		"stateCrouch":
			Crouching = true
		"stateJump":
			Jumping = true
		"stateFall":
			Falling = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clear_bools()
	for child in get_children():
		if child is StateMachine:
			StateMachineCurrent[child.get_name()] = child.CURRENT_STATE.name
			matchBool(child.CURRENT_STATE.name)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	clear_bools()
	for child in get_children():
		if child is StateMachine:
			StateMachineCurrent[child.get_name()] = child.CURRENT_STATE 
			matchBool(child.CURRENT_STATE.name)
			Debug.fpsControllerDebugPanel.add_property(child.get_name(), child.CURRENT_STATE.name, 1)
	
