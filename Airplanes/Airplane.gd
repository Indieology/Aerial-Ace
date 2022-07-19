extends KinematicBody2D

export var speed : int = 175
var velocity : Vector2 = Vector2.ZERO

func _ready():
	pass


func _physics_process(delta):
	var direction : Vector2 = Vector2.ZERO
	direction.x = Input.get_axis("move_left","move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	if direction.length() > 1:
		direction = direction.normalized()
	
	velocity = direction * speed
	position += velocity * delta
	
