extends Node

func _ready() -> void:
	SaveManger.save_value("alltime_local_game_x_wins",SaveManger.get_value("local_game_x_wins",0) + SaveManger.get_value("alltime_local_game_x_wins",0) )
	SaveManger.save_value("alltime_local_game_o_wins",SaveManger.get_value("local_game_o_wins",0) + SaveManger.get_value("alltime_local_game_o_wins",0) )
	SaveManger.save_value("alltime_vs_ai_game_x_wins",SaveManger.get_value("vs_ai_game_x_wins",0) + SaveManger.get_value("alltime_vs_ai_game_x_wins",0) )
	SaveManger.save_value("alltime_vs_ai_game_o_wins",SaveManger.get_value("vs_ai_game_o_wins",0) + SaveManger.get_value("alltime_vs_ai_game_o_wins",0) )
	
	SaveManger.save_value("vs_ai_game_o_wins",0)
	SaveManger.save_value("vs_ai_game_x_wins",0)
	SaveManger.save_value("local_game_o_wins",0)
	SaveManger.save_value("local_game_x_wins",0)
	
	SaveManger.save_game()
