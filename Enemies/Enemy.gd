extends KinematicBody2D

export var health : int = 8
export var score : int = 75
export var energy_dropped : int = 10
export var verticalSpeed : int = 20
export var horizontalSpeed : int = 50

onready var hurt_effect := preload("res://Effects/Hurt Effect.tscn")
onready var explosion := preload("res://Effects/Explosion/Explosion.tscn")

func _ready():
	add_to_group("damageable")

func _physics_process(delta):
	position.y += verticalSpeed * delta

func _on_Hurtbox_area_entered(area):
	var this_hurt_effect = hurt_effect.instance()
	get_parent().add_child(this_hurt_effect)
	this_hurt_effect.position = area.global_position
	if area.get_parent() is Player:
		area.get_parent().damage(1)
		#move hurt effect position to show collision between the two objects?
		
	
func damage(amount: int):
	health -= amount
	if health <= 0:
		var this_explosion := explosion.instance()
		get_parent().add_child(this_explosion)
		this_explosion.position = position
		get_parent().get_parent().get_node("Airplane").increase_score(score)
		get_parent().get_parent().get_node("Airplane").increase_energy(energy_dropped)
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
