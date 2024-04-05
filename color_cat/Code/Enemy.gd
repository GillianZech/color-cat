extends CharacterBody2D
@export var DEAD = false
@export var WALK_SPEED = 100
@export var DIRECTION = -1
@onready var cat = get_parent().get_parent().get_node("Cat")
var GRAVITY = 30
var JUMP_VELOCITY = -400

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if not DEAD:
		var DIRECT = cat.position.x - position.x
		if DIRECT >= 0:
			DIRECTION = 1
			$AnimatedSprite2D.flip_h = true
		else:
			DIRECTION = -1
			$AnimatedSprite2D.flip_h = false
		velocity.x = WALK_SPEED*DIRECTION
		if not is_on_floor():
			velocity.y += GRAVITY
		move_and_slide()

func die():
	DEAD = true
	velocity = Vector2.ZERO
	set_collision_layer_value(10, 0)
	set_collision_mask_value(1, 0)
	$StompBox.set_collision_mask_value(1, 0)
	#if $DeathTimer.is_stopped():
	$DeathTimer.start()
	$AnimationPlayer.play("Squish")

func _on_death_timer_timeout():
	queue_free()

func _on_stomp_box_body_entered(body):
	if not body.is_on_floor() and body.velocity.y >= 0:
		$HurtArea.set_collision_mask_value(1, 0)
		die()
		body.jump("high")
	pass # Replace with function body.


func _on_hurt_area_body_entered(body):
	body._die()
	pass # Replace with function body.
