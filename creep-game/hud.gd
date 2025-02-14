extends CanvasLayer

signal start_game #notifies 'Main' node that the button has been pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	#Wait until the MessageTimer has counted down 
	await $MessageTimer.timeout
	
	$Message.text = "Dodge the 
					Creeps!"
	$Message.show()
	
	#make a one-shot timer and wait for it to finish
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)



func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()
	pass # Replace with function body.


func _on_message_timer_timeout():
	$Message.hide()
	pass # Replace with function body.
