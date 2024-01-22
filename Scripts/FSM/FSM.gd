class_name StateMachine extends Node2D

var states: Dictionary = {}
@export var initial_state: State
var current_state: State
var changing_state: bool

func _ready():
	var stateList = get_children()
	for state in stateList:
		if state is State:
			states[state.name.to_lower()] = state
			state.state_transition.connect(change_state)
	if initial_state:
		initial_state.enter()
		current_state = initial_state
		print(current_state)

func _physics_process(_delta):
	if !changing_state:
		current_state.update(_delta)
	pass

func change_state(source_state: State, next_state_name: StringName):
	changing_state = true
	print("Source State Name: ",source_state.name)
#	if (next_state_name == source_state.name) or (next_state_name == current_state.name):
#		print("Error: Trying to change to the same state. Aborting. -> Current State: ",current_state.name, " // Next State: ", next_state_name)
#		return
	var next_state: State = states.get(next_state_name.to_lower())
	if !next_state:
		print("Next State is Empty! Aborting.")
		return
	if current_state:
		print("Exiting current State: ", current_state.name)
		current_state.exit()
	print("Entering Next State: ", next_state.name)
	next_state.enter()
	print("Assigning next State to current State")
	current_state = next_state
	print("State changed: ",current_state.name)
	changing_state = false
