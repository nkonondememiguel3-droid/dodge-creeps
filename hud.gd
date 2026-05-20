extends CanvasLayer

# notify the main node that the button has been pressed
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func show_message(text: String) -> void:
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Game Over")
	
	await $MessageTimer.timeout
	
	$Message.text = "Dodge the Creeps!"
	$Message.show()
	
	await get_tree().create_timer(1.0).timeout
	$StartButtom.show()


func update_score(score: int) -> void:
	$ScoreLabel.text = str(score)


func _on_start_buttom_pressed() -> void:
	$StartButtom.hide()
	start_game.emit()


func _on_message_timer_timeout() -> void:
	$Message.hide()
