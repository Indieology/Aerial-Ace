extends KinematicBody2D

export var max_speed : int = 175
var velocity : Vector2 = Vector2.ZERO

onready var camera = get_parent().get_node("Camera2D")

func _ready():
	pass


func _physics_process(delta):
	var direction : Vector2 = Vector2.ZERO
	direction.x = Input.get_axis("move_left","move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	if direction.length() > 1:
		direction = direction.normalized()
	
	velocity = direction * max_speed
	position += velocity * delta
	
	
	#var viewport := get_viewport_rect()
	position.x = clamp(position.x, camera.position.x - 190, camera.position.x + 190) 
	position.y = clamp(position.y, camera.position.y - 215, camera.position.y + 215)
