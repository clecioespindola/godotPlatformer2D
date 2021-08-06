extends KinematicBody2D

var UP = Vector2.UP
var velocity = Vector2.ZERO
var move_speed = 480
var gravity = 1200
var jump_force = -720
var is_grounded

#var player_health = 3
var max_health = 3

var hurted = false

var knockback_dir = 1
var knockback_int = 1000

var facingRight = true

var is_pushing = false

onready var raycasts = $raycasts

signal change_life(player_health)

func _ready() -> void:
	Global.set("player", self)
	connect("change_life", get_parent().get_node("HUD/HBoxContainer/Holder"), "on_change_life")
	emit_signal("change_life", max_health)
	if Global.checkpoint_pos != null:
		self.global_position.x = Global.checkpoint_pos

		
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.x = 0
	
	if !hurted:
		_get_input()
	
	if $pushRight.is_colliding():
		var object = $pushRight.get_collider()
		object.move_and_slide(Vector2(30,0) * move_speed * delta)
		is_pushing = true
	elif $pushLeft.is_colliding():
		var object = $pushLeft.get_collider()
		object.move_and_slide(Vector2(-60,0) * move_speed * delta)
		is_pushing = true
	else:
		is_pushing = false
		
	velocity = move_and_slide(velocity, UP)
	
	is_grounded = _check_is_ground()
	
	if is_grounded:
		$Shadow.visible = true
	else:
		$Shadow.visible = false
	
	_set_animation()
	
	for platforms in get_slide_count():
		var collision = get_slide_collision(platforms)
		if collision.collider.has_method("collide_with"):
			collision.collider.collide_with(collision, self)
			
func _get_input():
	velocity.x = 0
	var move_direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))	
	velocity.x = lerp(velocity.x, move_speed * move_direction, 0.2)
	
	if move_direction != 0:
		$texture.scale.x = move_direction
		$steps_fx.scale.x = move_direction
		
	if velocity.x > 1:
		$pushRight.set_enabled(true)
	else:
		$pushRight.set_enabled(false)
		
	if velocity.x < -1:
		$pushLeft.set_enabled(true)
	else:
		$pushLeft.set_enabled(false)
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") && is_grounded:
		velocity.y = jump_force / 2
		$jumpFx.play()

func _check_is_ground():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false

func _set_animation():
	var anim = "idle"
	
	if !is_grounded:
		anim = "jump"
	elif velocity.x != 0 or is_pushing:
		anim = "run"
		if is_grounded:
			$steps_fx.set_emitting(true)
					
	if velocity.y > 0 and !is_grounded:
		anim = "fall"	
	
	if hurted:
		anim = "hit"
		
	if $anim.assigned_animation != anim:
		$anim.play(anim)

func knockback():
	if $right.is_colliding():
		velocity.x = -knockback_dir * knockback_int
		
	if $left.is_colliding():
		velocity.x = knockback_dir * knockback_int
		
	velocity = move_and_slide(velocity)
	
func _on_hurtbox_body_entered(_body: Node) -> void:
	playerDamage()
		
func hit_checkpoint():
	Global.checkpoint_pos = global_position.x

func _on_headCollider_body_entered(body: Node) -> void:
	if body.has_method("destroy"):
		body.destroy()

func _on_hurtbox_area_entered(_area: Area2D) -> void:
	playerDamage()

func gameOver() -> void:
	if Global.player_health < 1:
		queue_free()
		Global.is_dead = true
		if get_tree().change_scene("res://Prefabs/GameOver.tscn") != OK:
			print("Algo deu errado!")
		
func playerDamage():
	Global.player_health -= 1
	hurted = true
	emit_signal("change_life", Global.player_health)
	knockback()
	get_node("hurtbox/collision").set_deferred("disabled", true)
	yield(get_tree().create_timer(0.5), "timeout")
	get_node("hurtbox/collision").set_deferred("disabled", false)
	hurted = false
	gameOver()


func _on_Trigger_PlayerEntered() -> void:
	$camera.current = false


func _on_Boss_BossDead() -> void:
	$camera.current = true
