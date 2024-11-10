extends RigidBody3D

signal  interacted(body)

@export var prompt_message = "Ligar"
@export var prompt_action = "interact"

@onready var luz = $OmniLight3D 

var light = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !light:
		prompt_message = "Ligar"
	else:
		prompt_message = "Desligar"
	
func get_promp():
	var Key_name = ""
	for action in InputMap.action_get_events(prompt_action):
		if action is InputEventKey:
			Key_name = OS.get_keycode_string(action.keycode)
	return prompt_message + "\n[E]"

	
func interaction(body):
		if light:
			luz.set_param(Light3D.PARAM_ENERGY,0)
			light = false
		else:
			luz.set_param(Light3D.PARAM_ENERGY,1)
			light = true
		print(luz.get_param(Light3D.PARAM_ENERGY))
