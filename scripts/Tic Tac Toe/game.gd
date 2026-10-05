extends Node
class_name GameManger
const MAIN_MENU = preload("uid://c55xtfjvabfj2")

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		change_scene(MAIN_MENU)

func change_scene(packed_scene:PackedScene):
	for i in get_children():
		i.queue_free()
	var instance = packed_scene.instantiate()
	add_child(instance)
