class_name StateMachine extends Node2D

var states: Dictionary = {}
@export var initial_state: State
var current_state: State

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
	current_state.update(_delta)

func change_state(source_state: State, next_state_name: StringName):
	if next_state_name == source_state.name:
		print("Error: Trying to change to the same state. Aborting.")
		return
	var next_state: State = states.get(next_state_name.to_lower())
	if !next_state:
		print("Next State is Empty! Aborting.")
		return
	if current_state:
		current_state.exit()
	next_state.enter()
	current_state = next_state
	print("State changed: ",next_state_name)

