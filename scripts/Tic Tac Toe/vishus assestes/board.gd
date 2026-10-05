@tool
extends Node2D

@export var redraw:bool:
	set(new_value):
		queue_redraw()
@export var size:float = 300:
	set(new_value):
		size = new_value
		queue_redraw()
@export var line_thickness: float =20:
	set(new_value):
		line_thickness = new_value
		queue_redraw()
@export var color:Color:
	set(new_value):
		color = new_value
		queue_redraw()
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	queue_redraw()

func _draw() -> void:
	var third_size: float = size/3
	var half_size: float = size/2
	var sixth_size: float = size/6
	
	draw_line(Vector2(sixth_size,half_size),Vector2(sixth_size,-half_size), color,line_thickness)
	draw_line(Vector2(-sixth_size,half_size),Vector2(-sixth_size,-half_size), color,line_thickness)
	draw_line(Vector2(half_size,sixth_size),Vector2(-half_size,sixth_size), color,line_thickness)
	draw_line(Vector2(half_size,-sixth_size),Vector2(-half_size,-sixth_size), color,line_thickness)
	
	var cap_positions: Array[Vector2] =[
		Vector2(sixth_size,half_size),
		Vector2(sixth_size,-half_size),
		Vector2(-sixth_size,half_size),
		Vector2(-sixth_size,-half_size),
		Vector2(half_size,sixth_size),
		Vector2(-half_size,sixth_size),
		Vector2(half_size,-sixth_size),
		Vector2(-half_size,-sixth_size),
	]
	for i in cap_positions:
		draw_circle(i,line_thickness/2,color)
