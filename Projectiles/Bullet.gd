extends Area2D

export var speed: int = 500

onready var bulletLifetime: Timer = $Lifetime

func _ready():
	bulletLifetime.start()

func _physics_process(delta):
	position.y -= speed * delta
	if bulletLifetime.is_stopped():
		queue_free()
