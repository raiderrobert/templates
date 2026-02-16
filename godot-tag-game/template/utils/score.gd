extends Label

var scores = {}  # Dictionary to store scores by player ID/prefix
const WINNING_SCORE = 5

var level

signal game_won(player_number: int)


func _ready() -> void:
	add_to_group("score_label")

	# Find the level node
	level = find_level_node()

	if level:
		# Connect to player management signals
		level.player_joined.connect(_on_player_joined)
		level.player_left.connect(_on_player_left)
		level.players_reorganized.connect(_on_players_reorganized)

		# Connect to existing players
		for player in level.active_players.values():
			connect_to_player(player)

	update_score_text()


# Helper function to find the level node
func find_level_node() -> Level:
	var level_nodes = get_tree().get_nodes_in_group("level")
	if level_nodes.size() > 0 and level_nodes[0] is Level:
		return level_nodes[0]
	return null


# Connect to a player's score signal
func connect_to_player(player: BasePlayer) -> void:
	if player and not player.running_timer_elapsed.is_connected(_on_player_running_timer_elapsed):
		print("Connecting to player:", player)

		if player.player_num and not scores.has(player.player_num):
			scores[player.player_num] = 0

		player.running_timer_elapsed.connect(_on_player_running_timer_elapsed)


# Disconnect from a player's score signal
func disconnect_from_player(player: BasePlayer) -> void:
	if player and player.score_updated.is_connected(_on_player_running_timer_elapsed):
		print("Disconnecting from player:", player)
		player.running_timer_elapsed.disconnect(_on_player_running_timer_elapsed)

		# Optionally, you could remove the player's score from our dictionary
		# var player_prefix = get_player_prefix(player)
		# if player_prefix and scores.has(player_prefix):
		#     scores.erase(player_prefix)
		# update_score_text()


# When a new player joins
func _on_player_joined(player: BasePlayer) -> void:
	connect_to_player(player)
	update_score_text()


# When a player leaves
func _on_player_left(player: BasePlayer) -> void:
	disconnect_from_player(player)
	update_score_text()


# When players are reorganized
func _on_players_reorganized(players: Array) -> void:
	for player in players:
		connect_to_player(player)
	update_score_text()


func _on_player_running_timer_elapsed(player_num: int) -> void:
	# Store the new score
	print("player " + str(player_num) + " score")
	scores[player_num] = scores[player_num] + 1

	# Check if this player has won
	if scores[player_num] >= WINNING_SCORE:
		emit_signal("game_won", player_num)

	update_score_text()


func update_score_text() -> void:
	var score_text = ""

	# Find the level to get current players
	var level = find_level_node()
	var active_players = []

	if level:
		active_players = level.active_players.values()

	# Sort players by their ID/prefix for consistent display
	var sorted_players = []
	for player in active_players:
		sorted_players.append(player)
	sorted_players.sort()

	var i = 0
	# Build score text with all active players
	for player in active_players:
		var score = scores.get(player.player_num, 0)

		score_text += "Player %d: %d" % [player.player_num, score]

		# Add separator between players except for the last one
		if i < active_players.size() - 1:
			score_text += " | "
		i = i + 1

	# If no players, show a default message
	if score_text.is_empty():
		score_text = "No players connected"

	text = score_text


func reset_scores() -> void:
	# Clear all scores
	scores.clear()

	# Find the level node
	var level = find_level_node()

	if level:
		# Re-initialize scores for current players
		for player in level.active_players.values():
			scores[player.player_num] = 0

	# Update the UI
	update_score_text()
