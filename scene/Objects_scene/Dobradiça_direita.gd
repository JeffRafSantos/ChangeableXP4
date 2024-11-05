extends Node3D


signal  interacted(body)

@export var prompt_message = "Interact"
@export var prompt_action = "interact"


@export var open = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_promp():
	var Key_name = ""
	for action in InputMap.action_get_events(prompt_action):
		if action is InputEventKey:
			Key_name = OS.get_keycode_string(action.keycode)
	if open == true:
		return "Abrir" + "\n[E]"
	else:
		return "Fechar" + "\n[E]"

func interaction(body):
	emit_signal("interacted")
# Called every frame. 'delta' is the elapsed time since the previous frame.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func Open():
	open = !open
	pass # Replace with function body.
