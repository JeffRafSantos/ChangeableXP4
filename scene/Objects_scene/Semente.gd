extends RigidBody3D

signal  interacted(body)

@export var prompt_message = "Interact"
@export var prompt_action = "interact"
# Called when the node enters the scene tree for the first time.


func _ready():
	pass
	
func get_promp():
	var Key_name = ""
	for action in InputMap.action_get_events(prompt_action):
		if action is InputEventKey:
			Key_name = OS.get_keycode_string(action.keycode)
	return prompt_message + "\n[" + Key_name + "]"
	
func interaction(body):
	print("Sementado")
	emit_signal("interacted",body)
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
