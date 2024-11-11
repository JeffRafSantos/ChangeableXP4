extends RigidBody3D


signal  interacted(body)

@export var prompt_message = "Tocar"
@export var prompt_action = "interact"
# Called when the node enters the scene tree for the first time.
var The_end = false
func _ready():
	$flor1.visible = false
	pass # Replace with function body.


func get_promp():
	var Key_name = ""
	for action in InputMap.action_get_events(prompt_action):
		if action is InputEventKey:
			Key_name = OS.get_keycode_string(action.keycode)
	if !The_end:
		return "Falta Algo"
	return prompt_message + "\n[E]"
	
func interaction(body):
		
		if The_end:
			get_tree().change_scene_to_file("res://scene/Vitória.tscn")
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_vaso_interacted(body):
		print("visivel")
		The_end = true
		$flor1.visible = true
		
