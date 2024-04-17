extends CharacterBody2D

@export var SPEED = 100
@export var DIRECTION = -1
@export var is_flying_enemy = false
@onready var cat = get_parent().get_parent().get_node("Cat")

var GRAVITY = 30
var JUMP_VELOCITY = -400
var DEAD = false

var TARGET_VECTOR = Vector2(0,0)
var ENGAGE_DISTANCE = 500

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if not DEAD and not get_parent().get_parent().get_parent().freeze:
		if is_flying_enemy:
			TARGET_VECTOR = cat.position - position
			if TARGET_VECTOR.length() < ENGAGE_DISTANCE:
				# normalized() makes it equal to 1 but keeps the coordinates
				# so it goes in the right direction
				TARGET_VECTOR = TARGET_VECTOR.normalized()
				velocity = TARGET_VECTOR * SPEED
			else:
				velocity = Vector2(0,0)
		else:
			var DIRECT = cat.position.x - position.x
			if DIRECT >= 0:
				DIRECTION = 1
				$AnimatedSprite2D.flip_h = true
			else:
				DIRECTION = -1
				$AnimatedSprite2D.flip_h = false
			TARGET_VECTOR = cat.position - position
			if TARGET_VECTOR.length() < ENGAGE_DISTANCE:
				TARGET_VECTOR = TARGET_VECTOR.normalized()
				velocity.x = SPEED*DIRECTION
			else:
				velocity.x = 0
			if not is_on_floor():
				velocity.y += GRAVITY
		#if $RayCast2D.is_colliding():
			#$RayCast2D.target_position.x = $RayCast2D.target_position.x + -1
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

func _on_hurt_area_body_entered(body):
	body._die()
