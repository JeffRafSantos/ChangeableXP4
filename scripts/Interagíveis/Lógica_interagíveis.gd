# Lógica de interagir
extends Node

# Variável para verificar uma condição concluída (ex: completar uma missão)
var condicao_concluida: bool = false

# Referência ao objeto interagível
@onready var objeto_interagivel = $ObjetoInteragivel

func _ready():
	# Conectar o sinal "interagiu" para realizar uma ação após a interação
	objeto_interagivel.connect("interagiu", Callable(self, "_ao_interagir"))
	# Chama a função completar_condicao após um tempo
	get_tree().create_timer(3.0).timeout.connect(Callable(self, "completar_condicao"))

# Função que define a condição
func completar_condicao():
	# Definir que a condição foi concluída
	condicao_concluida = true
	objeto_interagivel.definir_interagivel(true)

# Função chamada ao tentar interagir
func _ao_interagir():
	if condicao_concluida:
		# Ação específica para quando a condição foi completada
		print("Interação realizada com sucesso após completar a condição.")
	else:
		print("Condição não foi concluída.")
