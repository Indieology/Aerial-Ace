extends Area2D

export var speed: int = 175

onready var bulletLifetime: Timer = $Lifetime

onready var bulletEffect: = preload("res://Effects/Hurt Effect.tscn")

func _ready():
	bulletLifetime.start()

func _physics_process(delta):
	position.y += speed * delta
	if bulletLifetime.is_stopped():
		queue_free()


func _on_Bullet_area_entered(area):
	if area.get_parent().is_in_group("damageable"):
		var this_bullet_effect := bulletEffect.instance()
		this_bullet_effect.position = position
		get_parent().add_child(this_bullet_effect)
		area.get_parent().damage(1)
		queue_free()
