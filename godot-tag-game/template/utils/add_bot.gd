extends Button

@onready var bot_script = preload("res://scenes/bot_player.gd")

func _ready() -> void:
	connect("pressed", _on_button_pressed)

func _on_button_pressed() -> void:
	var level = get_tree().get_first_node_in_group("level") as Level
	if not level:
		return
		
	# Get the next available device ID
	var device_id = level.active_players.size()
	
	# Use the level's spawn_player function
	level.spawn_player(device_id)
	
	# Get the newly spawned player from the active_players dictionary
	if device_id in level.active_players:
		var bot = level.active_players[device_id]
		bot.set_script(bot_script)
