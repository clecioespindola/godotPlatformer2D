extends KinematicBody2D

onready var anim = $anim
onready var timer = $timer

onready var reset_position = global_position

var velocity = Vector2.ZERO
var gravity = 720
var is_triggered = false
export var reset_timer = 3.0

func _ready():
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	position += velocity * delta
	
func collide_with(_collision: KinematicCollision2D, _collider: KinematicBody2D):
	if !is_triggered:
		is_triggered = true
		anim.play("shake")
		velocity = Vector2.ZERO

func _on_anim_animation_finished(_anim_name: String) -> void:
	set_physics_process(true)
	timer.start(reset_timer)

func _on_timer_timeout() -> void:
	set_physics_process(false)
	yield(get_tree(), "physics_frame")
	var temp = collision_layer
	collision_layer = 0
	global_position = reset_position
	yield(get_tree(), "physics_frame")
	collision_layer = temp
	is_triggered = false
	
	
	
	
