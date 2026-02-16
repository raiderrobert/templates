extends Button
class_name ResetButton

signal game_reset


func _ready() -> void:
	# Connect the button press to our reset function
	pressed.connect(_on_reset_button_pressed)


func _on_reset_button_pressed() -> void:
	# Find score label and winner label
	var score_labels = get_tree().get_nodes_in_group("score_label")
	var winner_labels = get_tree().get_first_node_in_group("winner_label")

	# Reset the score
	if score_labels.size() > 0:
		score_labels[0].reset_scores()

	# Hide the winner label
	if winner_labels:
		winner_labels.visible = false
		if winner_labels.has_method("reset_winner"):
			winner_labels.reset_winner()

	# Emit signal for other components that might need to know
	emit_signal("game_reset")
