extends Control

@onready var ani = $AnimationPlayer
@onready var text = $VBoxContainer/Label
@onready var audio = $AudioStreamPlayer
# Called when the node enters the scene tree for the gfirst time.
var visible_characters = 0
func _ready():
	ani.play("Text")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible_characters != text.visible_characters:
		visible_characters = text.visible_characters
		audio.set_pitch_scale(randf_range(0.9,1.1))
		audio.play()
	pass

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scene/Primeira_Cena.tscn")


func _on_controls_pressed():
	get_tree().change_scene_to_file("res://scene/Controls.tscn")


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://scene/Credits.tscn")


func _on_quit_pressed():
	get_tree().quit()
