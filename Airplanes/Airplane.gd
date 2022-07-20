extends KinematicBody2D

var bullet := preload("res://Projectiles/Bullet.tscn")

export var max_speed : int = 175
export var horizontal_speed_multiplier: float = 1.2
var velocity : Vector2 = Vector2.ZERO

onready var camera = get_parent().get_node("Camera2D")
onready var guns = $Guns
onready var shootDelay = $ShootDelay

func _ready():
	pass

func _process(delta):
	if velocity.x > 0:
		rotation_degrees = 6
	elif velocity.x < 0:
		rotation_degrees = -6
	else:
		rotation_degrees = 0
		
	if Input.is_action_pressed("shoot") and shootDelay.is_stopped():
		shootDelay.start()
		for child in guns.get_children():
			var this_bullet := bullet.instance()
			get_parent().add_child(this_bullet)
			this_bullet.position = child.global_position

func _physics_process(delta):
	var direction : Vector2 = Vector2.ZERO
	direction.x = Input.get_axis("move_left","move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	if direction.length() > 1:
		direction = direction.normalized()
	
	velocity = direction * max_speed
	position.x += velocity.x * 1.2 * delta
	position.y += velocity.y * delta
	
	
	#var viewport := get_viewport_rect()
	position.x = clamp(position.x, camera.position.x - 190, camera.position.x + 190) 
	position.y = clamp(position.y, camera.position.y - 125, camera.position.y + 215)
