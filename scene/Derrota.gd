extends Control

@onready var ani = $AnimationPlayer
@onready var text = $VBoxContainer/Label
@onready var audio = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
var visible_characters = 0
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	ani.play("Text")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible_characters != text.visible_characters:
		visible_characters = text.visible_characters
		audio.set_pitch_scale(randf_range(0.9,1.1))
		audio.play()
	pass

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scene/Menu.tscn")
