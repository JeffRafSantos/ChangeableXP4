# Arquivo: Interactable.gd
extends Node2D

# Variável para checar se o objeto é interagível
var interagivel: bool = false

# Sinal que será emitido quando houver uma interação
signal interagiu

# Função para definir se o objeto está pronto para ser interagido
func definir_interagivel(valor: bool):
	# Atualiza a variável e emite um sinal se necessário
	interagivel = valor
	if interagivel:
		emit_signal("interagiu")

# Função chamada ao interagir com o objeto
func interagir():
	if interagivel:
		# Realize aqui a ação específica ao interagir
		print("Interagiu com o objeto.")
	else:
		print("Este objeto ainda não está disponível para interação.")
