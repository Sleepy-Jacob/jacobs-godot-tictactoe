extends Node
@onready var tic_tac_toe: Node = $"tic tac toe"

func _ready() -> void:
	tic_tac_toe.vs_ai = true
