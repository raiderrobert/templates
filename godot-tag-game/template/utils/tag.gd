extends Node

signal player_tagged(tagger: BasePlayer, tagged: BasePlayer)

const TAG_COOLDOWN: float = 1.0


func handle_tag(player: BasePlayer, other_player: BasePlayer):
	# Early out if both players have same tag status
	if player.tagger == other_player.tagger:
		return

	if player.tag_cooldown_timer > 0 or other_player.tag_cooldown_timer > 0:
		return

	var tagger = player if player.tagger else other_player
	var tagged = player if !player.tagger else other_player

	player_tagged.emit("player_tagged", tagger, tagged)

	# Swap tagger status
	player.tagger = !player.tagger
	other_player.tagger = !other_player.tagger
	player.tag_cooldown_timer = TAG_COOLDOWN
	other_player.tag_cooldown_timer = TAG_COOLDOWN

	var player_tagger_label = player.get_node("TaggerLabel")
	player_tagger_label.visible = !player_tagger_label.visible

	var other_player_tagger_label = other_player.get_node("TaggerLabel")
	other_player_tagger_label.visible = !other_player_tagger_label.visible
