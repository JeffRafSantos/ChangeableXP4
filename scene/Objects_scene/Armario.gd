extends Node3D

signal Open(body)

@onready var timer = $Timer
@export var prompt_message = "Interact"
@export var prompt_action = "interact"

@export var open = false
var playback = false
var interactable = true

func get_promp():
	var Key_name = ""
	for action in InputMap.action_get_events(prompt_action):
		if action is InputEventKey:
			Key_name = OS.get_keycode_string(action.keycode)
	if open == true:
		return "Abrir" + "\n[E]"
	else:
		return "Fechar" + "\n[E]"

# Called when the node enters the scene tree for the first time.
func _ready():
	playback = $AnimationTree.get("parameters/playback")
	playback.travel("Animation_Close")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func Armario_porta():
	if interactable == true:
		emit_signal("Open")
		interactable = false
		if open == true:
			open = false
			playback.travel("Animation_Close")
		elif open == false:
			open = true
			playback.travel("Animation_Open")
		timer.start()


func _picked_true():
	if interactable == true:
		emit_signal("Open")
		interactable = false
		if open == true:
			open = false
			playback.travel("Animation_Close")
		interactable = true


func _on_timer_timeout():
	interactable = true
