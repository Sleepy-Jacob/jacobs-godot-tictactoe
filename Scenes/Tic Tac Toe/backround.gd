extends ColorRect
@onready var tic_tac_toe: TicTacToe = $".."

@export var defalt_color:Color
@export var x_color:Color
@export var o_color:Color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color = defalt_color


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if tic_tac_toe.vs_ai == false:
		if tic_tac_toe.turn == TicTacToe.Turn.X:
			color = x_color
		else:
			color = o_color
