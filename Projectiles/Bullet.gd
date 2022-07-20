extends Area2D

export var speed: int = 500

onready var bulletLifetime: Timer = $Lifetime

func _ready():
	bulletLifetime.start()

func _physics_process(delta):
	position.y -= speed * delta
	if bulletLifetime.is_stopped():
		queue_free()


func _on_Bullet_area_entered(area):
	if area.get_parent().is_in_group("damageable"):
		area.get_parent().damage(1)
	queue_free()
