# Arquivo: Interactable.gd
extends Node3D

# Variável exportada para definir a interagibilidade no inspetor
@export var interagivel: bool = false

# Sinal emitido ao interagir com o objeto
signal interagiu

# Função para definir se o objeto é interagível (mude no inspetor)
func definir_interagivel(valor: bool):
	interagivel = valor

# Função para processar a interação
func tentar_interagir():
	if interagivel:
		emit_signal("interagiu")
	else:
		print("Este objeto ainda não está disponível para interação.")
