extends CharacterBody3D

const SPEED = 3.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var sensitivity = 0.1 #sensibilidade do mouse

func _ready():
	#iniciar gravação do mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass
	
func _input(event):
	#identifica se a entrada é a movimentação do mouse
	if event is InputEventMouseMotion:
		#rotaciona o player no eixo y
		rotate_y(- deg_to_rad(event.relative.x * sensitivity))
		#rotaciona a camera no eixo x
		$Camera3D.rotate_x(- deg_to_rad(event.relative.y * sensitivity))
		#ajusta a rotação da camera para previnir visão invertida
		var rotation_up = clamp($Camera3D.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		#camera recebe o novo angulo de visão
		$Camera3D.rotation.x = rotation_up
	elif event.is_action_pressed("b_quit"):
		#a entrada do jogador foi botão sair
		get_tree().quit() #encerra o jogo
	pass

func _physics_process(delta):
	var axys = Input.get_vector("b_left", "b_right", "b_up", "b_down")
	var vector_front = transform.basis.z * axys.y
	var vector_side = transform.basis.x * axys.x
	var vector_final = (vector_front + vector_side).normalized() * SPEED
	if is_on_floor():
		velocity.y = 0
		if Input.is_action_just_pressed("b_jump"):
			velocity.y = JUMP_VELOCITY
	else:
		velocity.y -= gravity * delta
	velocity = vector_final + Vector3(0, velocity.y, 0)
	move_and_slide()
	pass
