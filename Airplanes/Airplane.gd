extends KinematicBody2D
class_name Player

var bullet := preload("res://Projectiles/Bullet.tscn")

export var health: int = 5
export var current_energy: int = 0
export var max_speed : int = 110
export var horizontal_speed_multiplier: float = 2

var velocity : Vector2 = Vector2.ZERO
var score: int = 0

onready var camera = get_parent().get_node("Camera2D")
onready var guns = $Guns
onready var shootDelay = $ShootDelay
onready var invincibilityTimer = $InvincibilityTimer
onready var invincibilityAnimation = $InvincibilityAnimation

func _ready():
	get_parent().get_node("HUD").set_max_health(health)

func _process(delta):
	if velocity.x > 0:
		rotation_degrees = 5
	elif velocity.x < 0:
		rotation_degrees = -5
	else:
		rotation_degrees = 0
		
	if Input.is_action_pressed("shoot") and shootDelay.is_stopped():
		shootDelay.start()
		$LaserSound.play()
		for child in guns.get_children():
			var this_bullet := bullet.instance()
			get_parent().add_child(this_bullet)
			this_bullet.position = child.global_position
			var glow = child.get_child(0)
			glow.visible = true
			glow.get_child(0).start()
func _physics_process(delta):
	var direction : Vector2 = Vector2.ZERO
	direction.x = Input.get_axis("move_left","move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	if direction.length() > 1:
		direction = direction.normalized()
	
	velocity = direction * max_speed
	position.x += velocity.x * horizontal_speed_multiplier * delta
	position.y += velocity.y * delta
	
	
	#var viewport := get_viewport_rect()
	position.x = clamp(position.x, camera.position.x - 235, camera.position.x + 235) 
	position.y = clamp(position.y, camera.position.y - 145, camera.position.y + 265)

func damage(amount: int):
	if not invincibilityTimer.is_stopped():
		return
	invincibilityTimer.start()
	invincibilityAnimation.play("Flash")
	health -= amount
	get_parent().get_node("HUD").update_health(health)
	if health <= 0:
		queue_free()

func increase_score(score: int):
	var current_score = get_parent().get_node("HUD/Label").text.to_int()
	current_score += score
	get_parent().get_node("HUD/Label").text = str(current_score)
	get_parent().get_node("HUD/Label/AnimationPlayer").play("Increase Score")
	

func increase_energy(energy: int):
	get_parent().get_node("HUD").update_previous_energy(current_energy)
	if current_energy < 100:
		current_energy += energy
	if current_energy > 100:
		current_energy = 100
	get_parent().get_node("HUD").update_energy(current_energy)
