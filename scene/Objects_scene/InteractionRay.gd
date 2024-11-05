extends RayCast3D

# Called when the node enters the scene tree for the first time.
var obj_picked = false

func _ready():
	add_exception(owner)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_colliding():
		var detected = get_collider()
		
		if detected.is_in_group("Interacteble") and !obj_picked:
			$Prompt.text = detected.get_promp()
			
			if Input.is_action_just_pressed((detected.prompt_action)):
				detected.interaction(owner)
		else:
			$Prompt.text = "*"
	else:
			$Prompt.text = "*"
	pass


func _picked_true():
	obj_picked = true

func _picked_false():
	obj_picked = false
