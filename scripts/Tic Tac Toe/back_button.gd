extends Button

func _on_pressed() -> void:
	var game_manger:GameManger = get_tree().get_first_node_in_group("GameManger")
	game_manger.change_scene(load("res://Scenes/Main menu.tscn"))
