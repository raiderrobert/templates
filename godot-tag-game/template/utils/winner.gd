extends Label

var game_over = false


func _ready() -> void:
	add_to_group("winner_label")
	# Hide the label initially
	visible = false

	# Find the score label and connect to its game_won signal
	var score_label = get_tree().get_nodes_in_group("score_label")
	if score_label.size() > 0:
		score_label[0].game_won.connect(_on_game_won)


func _on_game_won(player_number: int) -> void:
	if !game_over:
		text = "Player %d Wins!" % player_number
		visible = true
		game_over = true


func reset_winner() -> void:
	game_over = false
	visible = false
	text = ""
