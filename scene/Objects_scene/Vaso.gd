extends RigidBody3D

signal  interacted(body)

@export var prompt_message = "Plantar"
@export var prompt_action = "interact"
@onready var audio_player = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.

@export var in_seed = false

func _ready():
	pass

func get_promp():
	var Key_name = ""
	for action in InputMap.action_get_events(prompt_action):
		if action is InputEventKey:
			Key_name = OS.get_keycode_string(action.keycode)
	if !in_seed:
		return "Falta Algo"
	return prompt_message + "\n[E]"
	
func interaction(body):
	if in_seed:
		audio_player.play()
		emit_signal("interacted", body)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_semente_interacted(body):
	in_seed = true
	pass # Replace with function body.
