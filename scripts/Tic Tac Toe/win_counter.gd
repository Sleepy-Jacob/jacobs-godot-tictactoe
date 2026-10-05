extends Control
@export var x_lable:Label
@export var o_lable:Label
@onready var tic_tac_toe: TicTacToe = $".."

@export var draw_count:Label

const MAX_AI_DRAW_COUNT: String = "max_ai_draw_count"

var draw_counter: int = 0:
	set(new_value):
		draw_counter = new_value
		draw_count.text = str(draw_counter)

		if tic_tac_toe.vs_ai:
			var current_max: int = SaveManger.get_value(MAX_AI_DRAW_COUNT, 0)
			if draw_counter > current_max:
				SaveManger.save_value(MAX_AI_DRAW_COUNT, draw_counter)

		SaveManger.save_game()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_win_counter()
	draw_count.text = str(draw_counter)

func update_win_counter():
	if tic_tac_toe.vs_ai == false:
		var key:String = "local_game_o_wins"
		o_lable.text = str(int(SaveManger.get_value(key, 0)))
		key = "local_game_x_wins"
		x_lable.text = str(int(SaveManger.get_value(key, 0)))
	else:
		var key:String = "vs_ai_game_o_wins"
		o_lable.text = str(int(SaveManger.get_value(key, 0)))
		key = "vs_ai_game_x_wins"
		x_lable.text = str(int(SaveManger.get_value(key, 0)))
