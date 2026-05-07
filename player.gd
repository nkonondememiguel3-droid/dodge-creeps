extends Area2D

signal hit

@export var speed = 400
var screen_window
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_window = get_viewport_rect().size
	
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # the player's movement verctor
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		# $AnimatedSprite2D.play()
		get_node("AnimatedSprite2D").play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position.clamp(Vector2.ZERO, screen_window)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 1:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0


func _on_body_entered(body: Node2D) -> void:
	hide()
	
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos: Vector2):
	position = pos
	show()
	$CollisionShape2D.disabled = false
