extends TouchScreenButton

@export var tic_tac_toe: Node 

signal tile_activeted(position:Vector2i)

@export var board_position:Vector2i

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_on_pressed)
	released.connect(_on_released)
	tile_activeted.connect(tic_tac_toe.on_button_tile_activeted) 
	
	if board_position == Vector2i(-1, -1):
		breakpoint


func _on_pressed() -> void:
	emit_signal("tile_activeted",board_position)



func _on_released() -> void:
	pass # Replace with function body.
