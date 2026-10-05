extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_local_game_pressed() -> void:
	var game_manger:GameManger = get_tree().get_first_node_in_group("GameManger")
	game_manger.change_scene(load("uid://bhrfy2q2k7nph"))


func _on_vs_ai_pressed() -> void:
	var game_manger:GameManger = get_tree().get_first_node_in_group("GameManger")
	game_manger.change_scene(load("uid://cnub6moktei6d"))


func _on_stats_pressed() -> void:
	var game_manger:GameManger = get_tree().get_first_node_in_group("GameManger")
	game_manger.change_scene(load("uid://dsaqt2k4svjvc"))
