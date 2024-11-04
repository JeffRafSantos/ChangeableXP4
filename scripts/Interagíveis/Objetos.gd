# Objetos
extends Node

# Variáveis para os objetos interagíveis e o RayCast3D
@onready var objeto_1 = $Objeto1
@onready var objeto_2 = $Objeto2

# Variável para a RayCast3D do jogador
var player_raycast

# Variável para verificar se a interação com Objeto1 foi concluída
var interacao_objeto1_concluida: bool = false

func _ready():
	# Encontrar o jogador na cena (já q nesse caso o Script q está com o codigo está no mesmo parente do player)
	var player = get_parent().get_node("player")  # achar player
	player_raycast = player.get_node("Camera3D/RayCast3D")  # pegar raycast da cena do player

	# Conectar os sinais de interação de ambos os objetos
	objeto_1.connect("interagiu", Callable(self, "_ao_interagir_objeto1"))
	objeto_2.connect("interagiu", Callable(self, "_ao_interagir_objeto2"))

func _process(delta):
	# Detecta o pressionamento da tecla "E"
	if Input.is_action_just_pressed("ui_accept"):
		# Verifica se o RayCast3D está colidindo com um objeto interagível
		if player_raycast and player_raycast.is_colliding():
			var objeto = player_raycast.get_collider()
			if objeto == objeto_1 and objeto_1.interagivel:
				objeto_1.tentar_interagir()
			elif objeto == objeto_2 and objeto_2.interagivel:
				objeto_2.tentar_interagir()

# Função chamada ao interagir com o Objeto1
func _ao_interagir_objeto1():
	print("Interagiu com o Objeto 1.")
	interacao_objeto1_concluida = true
	objeto_2.definir_interagivel(true)

# Função chamada ao interagir com o Objeto2
func _ao_interagir_objeto2():
	if interacao_objeto1_concluida:
		print("Interagiu com o Objeto 2 após concluir a interação com o Objeto 1.")
	else:
		print("Condição para Objeto 2 não cumprida.")
