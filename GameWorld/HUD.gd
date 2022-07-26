extends CanvasLayer

onready var HealthBar := $VBoxContainer/HealthBar

func _ready():
	update_health(10)


func update_health(health: int):
	HealthBar.value = health

func set_max_health(max_health: int):
	HealthBar.max_value = max_health
