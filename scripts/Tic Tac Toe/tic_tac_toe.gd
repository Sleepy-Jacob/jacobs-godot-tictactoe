extends Node
class_name TicTacToe
@export var turn_o: Node2D
@export var turn_x: Node2D
@onready var win_screen: Control = $"win screen"

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var win_counter: Control = $"Win Counter"

@export var vs_ai:bool = false

@export var recive_inputs:bool:
	set(new_value):
		recive_inputs = new_value
		toggle_touch_screen_buttons()
@export var touchscreen_buttons:Array[Node2D]



enum Turn{
	X,
	O
}

var turn:Turn = Turn.X


const BOARD_SIZE:Vector2i = Vector2i(3,3)
var board: Array[Array]

enum Piece{
	EMPTEY,
	X,
	O
}

enum Game_Result{
	X_WIN,
	O_WIN,
	DRAW,
	NO_RESULT
}


func  _ready() -> void:
	for x in BOARD_SIZE.x:
		board.append([])
		for y in BOARD_SIZE.y:
			board[x].append(Piece.EMPTEY)
	
	update_board_display()
	print(board)

func toggle_touch_screen_buttons():
	if recive_inputs == false:
		for i in touchscreen_buttons:
			i.hide()
	else:
		for i in touchscreen_buttons:
			i.show()

func rest_board():
	board = []
	for x in BOARD_SIZE.x:
		board.append([])
		for y in BOARD_SIZE.y:
			board[x].append(Piece.EMPTEY)
	

func place_piece(positon:Vector2i):
	if turn == Turn.X:
		board[positon.x][positon.y] = Piece.X
	else:
		board[positon.x][positon.y] = Piece.O

func check_position(position:Vector2i) -> Piece:
	return board[position.x][position.y]


func update_board_display():
	win_counter.update_win_counter()
	if turn == Turn.X:
		turn_o.hide()
		turn_x.show()
	else:
		turn_x.hide()
		turn_o.show()
	
	var x_pieces:Array = %"X peices".get_children()
	var o_pieces:Array = %"O pieces".get_children()
	
	for i in x_pieces:
		i.hide()
	for i in o_pieces:
		i.hide()
	
	var count:int = 0
	for x in BOARD_SIZE.x:
		for y in BOARD_SIZE.y:
			if board[x][y] == Piece.X:
				x_pieces[count].show()
			elif board[x][y] == Piece.O:
				o_pieces[count].show()
			else:
				x_pieces[count].hide()
				o_pieces[count].hide()
			count += 1
	
	

func cheack_for_victory_or_draw() -> Game_Result:
	for x in BOARD_SIZE.x:
		if board[x][0] == board[x][1] and board[x][1] == board[x][2] and board[x][2] == board[x][0]:
			if board[x][0] == Piece.X:
				return Game_Result.X_WIN
			elif board[x][0] == Piece.O:
				return Game_Result.O_WIN
	
	for y in BOARD_SIZE.y:
		if board[0][y] == board[1][y] and board[1][y] == board[2][y] and board[2][y] == board[0][y]:
			if board[0][y] == Piece.X:
				return Game_Result.X_WIN
			elif board[0][y] == Piece.O:
				return Game_Result.O_WIN		
	
	
	var diagnal:Array = [
		board[0][0],
		board[1][1],
		board[2][2]
	]
	if diagnal[0] != Piece.EMPTEY and diagnal[0] == diagnal[1] and diagnal[1] == diagnal[2]:
		if diagnal[0] == Piece.X:
			return Game_Result.X_WIN
		elif diagnal[0] == Piece.O:
			return Game_Result.O_WIN
	diagnal = [
		board[2][0],
		board[1][1],
		board[0][2]
	]
	if diagnal[0] != Piece.EMPTEY and diagnal[0] == diagnal[1] and diagnal[1] == diagnal[2]:
		if diagnal[0] == Piece.X:
			return Game_Result.X_WIN
		elif diagnal[0] == Piece.O:
			return Game_Result.O_WIN
	
	
	var empty_price:int = 0
	for x in BOARD_SIZE.x:
		for y in BOARD_SIZE.y:
			if board[x][y] == Piece.EMPTEY:
				empty_price += 1
	if empty_price == 0:
		return Game_Result.DRAW
	
	return Game_Result.NO_RESULT


func place_pice(piece:Piece,position: Vector2i):
	board[position.x][position.y] = piece
	update_board_display()
	end_game_if_possable()


func on_button_tile_activeted(position: Vector2i) -> void:
	if not recive_inputs:
		return
	if board[position.x][position.y] != Piece.EMPTEY:
		return
	if vs_ai:
		on_button_pressed_vs_ai(position)
		return
	match turn:
		Turn.X:
			turn = Turn.O
			place_pice(Piece.X,position)
			
		Turn.O:
			turn = Turn.X
			place_pice(Piece.O,position)
	recive_inputs = false
	await  get_tree().create_timer(0.5).timeout 
	recive_inputs = true
			

func on_button_pressed_vs_ai(position:Vector2i):
	place_pice(Piece.X,position)
	if cheack_for_victory_or_draw() != Game_Result.NO_RESULT:
		return
	if board == [[0, 0, 0], [0, 0, 0], [0, 0, 0]]:
		return
	take_ai_turn()
	recive_inputs = false
	await  get_tree().create_timer(0.2).timeout 
	recive_inputs = true




func take_ai_turn():
	##get board find piece_position
	place_pice(Piece.O,find_best_move(board))
	turn = Turn.X

func end_game_if_possable():
	var game_result:Game_Result = cheack_for_victory_or_draw()
	update_board_display()
	match game_result:
		Game_Result.X_WIN:
			win_counter.draw_counter = 0
			print("x win")
			rest_board()
			animation_player.play("X_wins")
			if vs_ai == false:
				var key:String = "local_game_x_wins"
				var past_wins:int= SaveManger.get_value(key,0)
				SaveManger.save_value(key,past_wins+1)
			else:
				var key:String = "vs_ai_game_x_wins"
				var past_wins:int= SaveManger.get_value(key,0)
				SaveManger.save_value(key,past_wins+1)
		Game_Result.O_WIN:
			win_counter.draw_counter = 0
			print("o win")
			rest_board()
			animation_player.play("O_wins")
			if vs_ai == false:
				var key:String = "local_game_o_wins"
				var past_wins:int= SaveManger.get_value(key,0)
				SaveManger.save_value(key,past_wins+1)
			else:
				var key:String = "vs_ai_game_o_wins"
				var past_wins:int= SaveManger.get_value(key,0)
				SaveManger.save_value(key,past_wins+1)
		Game_Result.DRAW:
			print("draw")
			rest_board()
			animation_player.play("Draw")
			win_counter.draw_counter += 1
		Game_Result.NO_RESULT:
			pass
	SaveManger.save_game()

func show_win_screen(result:Game_Result):
	win_screen.show()

	await get_tree().create_timer(1).timeout
	win_screen.hide()


func find_best_move(_board:Array) -> Vector2i:
	var ai:AI_Move = AI_Move.new(_board,Turn.O)
	return ai.get_best_move()

class AI_Move:
	var move:Vector2i
	
	var board:Array
	var branch_value:int = 0 #1 for win -1 for lose 0 for draw if no result branch value is sum of children

			
	var players_turn:Turn
	
	var parent_ref: WeakRef = null
	var children:Array[AI_Move]
	
	func _init(board_:Array, player_turn:Turn, parent:AI_Move = null) -> void:
		players_turn = player_turn
		board = board_
		if parent:
			parent_ref = weakref(parent)
		
		var game_result:Game_Result = cheack_for_victory_or_draw()
		match game_result:
			Game_Result.O_WIN: 
				branch_value = 1
			Game_Result.DRAW: 
				branch_value = 0
			Game_Result.X_WIN: 
				branch_value = -1
		if game_result != Game_Result.NO_RESULT and parent_ref:
			var parent_:AI_Move = parent_ref.get_ref()
			if parent_.branch_value <= branch_value:
				parent_.branch_value = branch_value
			
			
		if game_result == Game_Result.NO_RESULT:
			branch_and_cheack_fuctures()
	
	func branch_and_cheack_fuctures():
		for x in board.size():
			for y in board[x].size():
				if board[x][y] != Piece.EMPTEY:
					continue
				var new_board = board.duplicate(true)
				var next_turn: Turn
				if players_turn == Turn.X:
					new_board[x][y] = Piece.X
					next_turn = Turn.O
				else:
					new_board[x][y] = Piece.O
					next_turn = Turn.X

				var child_ai_turn := AI_Move.new(new_board, next_turn, self)
				child_ai_turn.move = Vector2i(x, y)
				children.append(child_ai_turn)

		# minimax: O (this node's mover) picks the max; X picks the min
		if children.size() > 0:
			var best_value = children[0].branch_value
			if players_turn == Turn.O:
				for c in children:
					if c.branch_value > best_value:
						best_value = c.branch_value
			else:
				for c in children:
					if c.branch_value < best_value:
						best_value = c.branch_value
			branch_value = best_value

	func get_best_move() -> Vector2i:
		if children.is_empty():
			print("reeor")
			return Vector2i(-1, -1)
		var best_child := children[0]
		for c in children:
			if c.branch_value > best_child.branch_value:
				best_child = c
		return best_child.move
	

	func cheack_for_victory_or_draw() -> Game_Result:
		for x in BOARD_SIZE.x:
			if board[x][0] == board[x][1] and board[x][1] == board[x][2] and board[x][2] == board[x][0]:
				if board[x][0] == Piece.X:
					return Game_Result.X_WIN
				elif board[x][0] == Piece.O:
					return Game_Result.O_WIN
		
		for y in BOARD_SIZE.y:
			if board[0][y] == board[1][y] and board[1][y] == board[2][y] and board[2][y] == board[0][y]:
				if board[0][y] == Piece.X:
					return Game_Result.X_WIN
				elif board[0][y] == Piece.O:
					return Game_Result.O_WIN		
		
		
		var diagnal:Array = [
			board[0][0],
			board[1][1],
			board[2][2]
		]
		if diagnal[0] != Piece.EMPTEY and diagnal[0] == diagnal[1] and diagnal[1] == diagnal[2]:
			if diagnal[0] == Piece.X:
				return Game_Result.X_WIN
			elif diagnal[0] == Piece.O:
				return Game_Result.O_WIN
		diagnal = [
			board[2][0],
			board[1][1],
			board[0][2]
		]
		if diagnal[0] != Piece.EMPTEY and diagnal[0] == diagnal[1] and diagnal[1] == diagnal[2]:
			if diagnal[0] == Piece.X:
				return Game_Result.X_WIN
			elif diagnal[0] == Piece.O:
				return Game_Result.O_WIN
		
		
		var empty_price:int = 0
		for x in BOARD_SIZE.x:
			for y in BOARD_SIZE.y:
				if board[x][y] == Piece.EMPTEY:
					empty_price += 1
		if empty_price == 0:
			return Game_Result.DRAW
		
		return Game_Result.NO_RESULT
	
