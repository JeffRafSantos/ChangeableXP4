extends CharacterBody3D

@onready var Head = $"Head"
@onready var Grab = $"Head/GrabRay"
@onready var point = $"Head/Hold"
@onready var joint = $"Head/Generic6DOFJoint3D"
@onready var staticbody = $Head/StaticBody3D

var picked_object
var pull_power = 4
var rotation_power = 0.05

var locked = false
const SPEED = 3.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var sensitivity = 0.1 #sensibilidade do mouse

func _ready():
	#iniciar gravação do mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass
	
func _input(event):
#identifica se a entrada é a movimentação do mouse
	
	if !locked:
		Player_rotation(event)
	
	if Input.is_action_just_pressed("inspect"):
		locked = !locked
	
	if event.is_action_pressed("b_quit"):
		#a entrada do jogador foi botão sair
		get_tree().quit() #encerra o jogo
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if picked_object == null:
			pick_object()
		elif picked_object != null:
			remove_object()
	if Input.is_action_just_pressed("b_up"):
		pull_power == 10
	else: 
		(pull_power == 4)
	pass
	
func _process(delta):
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if picked_object == null:
			pick_object()
		elif picked_object != null:
			remove_object()

	if picked_object != null:
		var a = picked_object.global_position
		var b = point.global_position
		picked_object.set_linear_velocity((b-a)*pull_power)
		

func _physics_process(delta):
	var axys = Input.get_vector("b_left", "b_right", "b_up", "b_down")
	var vector_front = transform.basis.z * axys.y
	var vector_side = transform.basis.x * axys.x
	var vector_final = (vector_front + vector_side).normalized() * SPEED
	if !locked:
		if is_on_floor():
			velocity.y = 0
			if Input.is_action_just_pressed("b_jump"):
				velocity.y = JUMP_VELOCITY
		else:
			velocity.y -= gravity * delta
		velocity = vector_final + Vector3(0, velocity.y, 0)
		move_and_slide()
	pass

func Player_rotation(event):
	if event is InputEventMouseMotion:
		#rotaciona o player no eixo y
		rotate_y(- deg_to_rad(event.relative.x * sensitivity))
		#rotaciona a camera no eixo x
		Head.rotate_x(- deg_to_rad(event.relative.y * sensitivity))
		#ajusta a rotação da camera para previnir visão invertida
		var rotation_up = clamp(Head.rotation.x, deg_to_rad(-80), deg_to_rad(60))
		#camera recebe o novo angulo de visão
		Head.rotation.x = rotation_up

func pick_object():
	var collider = Grab.get_collider()
	if collider != null and collider.is_in_group("grab"):
		picked_object = collider
		#joint.set_node_b(picked_object.get_path())

func remove_object():
	picked_object = null
	#joint.set_node_b(joint.get_path())

func rotate_object(event):
	if picked_object != null:
		if event is InputEventMouseMotion:
			staticbody.rotate_x(deg_to_rad(event.relative.y * rotation_power))
			staticbody.rotate_y(deg_to_rad(event.relative.x * rotation_power))
	
