extends Camera2D

const MIN_ZOOM = .4
const MAX_ZOOM = 2
const ZOOM_SPEED = .8

var level


func _ready() -> void:
	# Get reference to the level node that contains the active_players dictionary
	level = get_parent()


func _process(delta: float) -> void:
	var players = level.active_players.values()

	# Only adjust camera if there are players
	if players.size() > 0:
		# Calculate the center position of all players
		var center = Vector2.ZERO
		for player in players:
			center += player.position

		center /= players.size()
		position = center

		# Calculate zoom based on player spread if there are multiple players
		if players.size() > 1:
			var max_distance = 0

			# Find the maximum distance between any two players
			for i in range(players.size()):
				for j in range(i + 1, players.size()):
					var distance = players[i].position.distance_to(players[j].position)
					max_distance = max(max_distance, distance)

			# Adjust zoom based on max distance
			var zoom_factor = clamp(1 / (max_distance / 1500), MIN_ZOOM, MAX_ZOOM)
			zoom = zoom.lerp(Vector2(zoom_factor, zoom_factor), delta * ZOOM_SPEED)
		else:
			# If only one player, use default zoom
			zoom = zoom.lerp(Vector2(1, 1), delta * ZOOM_SPEED)
