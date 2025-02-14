extends Area2D
signal hit #will be used when player collides with enemy 

@export var speed = 400 #How fast the player will move 
var screen_size #Size of the game 


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO #The player's movement vector
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta # updating the players position
	position = position.clamp(Vector2.ZERO, screen_size) # this will help from the player leaving screen
	
	#changes the movement based on direction
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		
		$AnimatedSprite2D.flip_h = velocity.x < 0 #flips the animation horizontally for the left movement 
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0 # flips vertically for the down movement
		
	pass


func _on_body_entered(body):
	hide() #player disappears after being hit.
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true) #waits to disable the shape until its safe
	pass # Replace with function body.

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false 
	
