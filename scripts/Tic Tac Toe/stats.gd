extends Control
@export var label: Label
const MAX_AI_DRAW_COUNT:String = "max_ai_draw_count"

func _ready() -> void:
	var total_x_wins = SaveManger.get_value("alltime_local_game_x_wins",0)
	var total_o_wins = SaveManger.get_value("alltime_local_game_o_wins",0)
	var longest_ai_game = SaveManger.get_value(MAX_AI_DRAW_COUNT,0)
	var total_ai_wins = SaveManger.get_value("alltime_vs_ai_game_o_wins",0)
	
	# Cleaned version — no leading/trailing blank line
	var text_clean := """
Total X Wins: %d
Total O Wins: %d
Longest AI Game: %d Draws
Total AI Wins: %d""" % [total_x_wins, total_o_wins, longest_ai_game, total_ai_wins]
	label.text = text_clean
