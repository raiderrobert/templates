extends BasePlayer
class_name BotPlayer

var target_player: BasePlayer = null


func _ready() -> void:
	super._ready()


func _physics_process(delta: float) -> void:
	find_target()
	if target_player:
		move_towards_target(delta)

	handle_dash(delta)
	handle_collision(delta)

	if dash_timer <= 0:
		velocity = velocity - (velocity * 1.9) * delta  # sets friction
		velocity = velocity.clampf(-1000, 1000)  # sets top speed

	if tag_cooldown_timer > 0:
		tag_cooldown_timer = tag_cooldown_timer - delta

	# Update running timer and score for non-taggers
	if !tagger:
		running_timer += delta
		if running_timer >= SCORE_INTERVAL:
			running_timer -= SCORE_INTERVAL
			running_timer_elapsed.emit(player_num)
		$TaggerLabel.visible = true
		$TaggerLabel.text = "%.1f" % (SCORE_INTERVAL - running_timer)
	else:
		$TaggerLabel.visible = tagger
		$TaggerLabel.text = "Bot Tagger"


func find_target() -> void:
	var players = get_tree().get_nodes_in_group("players")
	target_player = null

	for player in players:
		if player == self:
			continue

		if (tagger and not player.tagger) or (not tagger and player.tagger):
			target_player = player


func move_towards_target(delta: float) -> void:
	if not target_player:
		return

	var direction = (target_player.global_position - global_position).normalized()

	# If we're not the tagger, move away from taggers
	if not tagger and target_player.tagger:
		direction = -direction

	velocity = velocity + ((direction * base_speed) * .5) * delta
