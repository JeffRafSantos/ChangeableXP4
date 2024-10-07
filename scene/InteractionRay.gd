extends RayCast3D

# Called when the node enters the scene tree for the first time.
func _ready():
	add_exception(owner)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_colliding():
		var detected = get_collider()
		
		if detected is Interactable:
			$Prompt.text = detected.get_promp()
			
			if Input.is_action_just_pressed((detected.prompt_action)):
				detected.interaction(owner)
	else:
		$Prompt.text = "*"
	pass
