extends CharacterBody3D

@onready var Head = $"Head"
@onready var Grab = $"Head/GrabRay"
@onready var point = $"Head/Hold"

var picked_object: RigidBody3D
var pull_power = 10
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
	
func _unhandled_input(event):
#identifica se a entrada é a movimentação do mouse
	
	if !locked:
		Player_rotation(event)
	else:
		rotate_object(event)
	
	if Input.is_action_just_pressed("inspect") and picked_object != null:
		locked = !locked
	
	if event.is_action_pressed("b_quit"):
		#a entrada do jogador foi botão sair
		get_tree().quit() #encerra o jogo
	
	#se o botão esquerdo do mouse for pressionado
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if picked_object == null:
			pick_object()
		elif picked_object != null and locked == false:
			remove_object()
	
	if Input.is_action_just_pressed("b_up"):
		pull_power = 20
	else: 
		pull_power = 10
	pass
	
func _process(delta):
	var b = point.global_position
	if picked_object != null:
		var a = picked_object.global_position
		var dir : Vector3 = a.direction_to(b)
		var dist : float = a.distance_to(b) * pull_power
		if !locked:
			picked_object.set_freeze_enabled(false)
			#picked_object.look_at_from_position(lerp(a,b,0.1),Head.global_position)
			#picked_object.set_linear_velocity((b-a)*pull_power)
			picked_object.move_and_collide((dir * dist)*delta)
			picked_object.look_at(self.global_position)
		else:
			#picked_object.position = b
			picked_object.move_and_collide((dir * dist)*delta)
			picked_object.set_freeze_enabled(true)

func _physics_process(delta):
	var axys = Input.get_vector("b_left", "b_right", "b_up", "b_down")
	var vector_front = transform.basis.z * axys.y
	var vector_side = transform.basis.x * axys.x
	var vector_final = (vector_front + vector_side).normalized() * SPEED
	if !locked:
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

func remove_object():
	picked_object.set_linear_velocity(Vector3(0,0.001,0))
	picked_object = null

func rotate_object(event):
	if picked_object != null:
		if event is InputEventMouseMotion:
			picked_object.rotation.y = (picked_object.rotation.y + (event.relative.x) * 0.005)
			picked_object.rotation.x = (picked_object.rotation.x + (event.relative.y) * 0.005)
			#picked_object.apply_torque(Vector3(event.relative.x,event.relative.y,0))
			#print(event.relative, " ", picked_object.rotation)
