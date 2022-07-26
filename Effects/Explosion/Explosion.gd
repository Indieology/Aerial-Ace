extends Node2D

func _ready():
	$CPUParticles2D.emitting = false
	$CPUParticles2D2.emitting = false
	$CPUParticles2D3.emitting = false
	


func _on_Timer_timeout():
	$CPUParticles2D.restart()
	$CPUParticles2D2.restart()
	$CPUParticles2D3.restart()
