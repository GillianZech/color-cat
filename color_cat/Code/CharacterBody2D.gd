extends CharacterBody2D

var INPUT_VECTOR = Vector2(0,0)
var SPEED = 600
var GRAVITY = 25
var JUMP_STRENGTH = -625
var ACCELERATION = 30
var PAINT_COLOR = "Gray"
var DJUMP_USED = false
var DOORS_LOCKED
var FOOD_COUNT
var FOOD_APPEARED
var DEAD = false

@onready var ANIM_SPRITE = $CatSprite
@onready var ANIM_PLAYER = $AnimationPlayer
@onready var DUST_PARTICLES = $DustParticles
@onready var JUMP_AUDIO = $JumpAudio
@onready var WALK_AUDIO = $WalkAudio
@onready var CURRENT_LASER
@onready var LASER_COUNT

#@export var DOORS_PARENT: Node2D
#@onready var DOORS_PARENT: Node2D
@onready var DOORS: Array
#@onready var CAN_PARENT: Node2D
@onready var FOOD: Array
#@onready var LASERS_PARENT: Node2D
@onready var LASERS: Array
@onready var BUCKETS: Array

@onready var LOCK_AUDIO
@onready var UNLOCK_AUDIO

# Code that runs at the start of the game
func _ready():
	_reset()
	
func _reset():
	FOOD_APPEARED = false
	DOORS_LOCKED = true
	CURRENT_LASER = 0
	LASER_COUNT = 0
	FOOD_COUNT = 0
	get_parent().get_parent().get_node("HUD").update_score(FOOD_COUNT, false)
	if get_parent().get_node("EndArea"):
		get_parent().get_node("EndArea").visible = false
	
	# Buckets
	if get_parent().get_node("Buckets"): # if getting this node returns not null
		BUCKETS = get_parent().get_node("Buckets").get_children()
		if BUCKETS != []:
			for bucket in BUCKETS:
				bucket.get_node("BucketSprite").play("idle")
	else:
		BUCKETS = []
		
	# Doors
	if get_parent().get_node("Doors"): # if getting this node returns not null
		DOORS = get_parent().get_node("Doors").get_children()
	else:
		DOORS = []
	
	# Food
	if get_parent().get_node("Food"):
		FOOD = get_parent().get_node("Food").get_children()
		if FOOD != []:
			for can in FOOD:
				can.visible = false
	else:
		FOOD = []
		
	# Lasers
	if get_parent().get_node("Lasers"):
		LASERS = get_parent().get_node("Lasers").get_children()
		if LASERS != []:
			for laser in LASERS:
				laser.visible = false
				LASER_COUNT+=1 # won't change throughout the level but will be different by level
			get_parent().get_node("Lasers").get_child(0).visible = true
	else:
		LASERS = []
		if get_parent().get_node("EndArea"):
			get_parent().get_node("EndArea").visible = true

func _jump_animation():
	ANIM_SPRITE.play("jump")
	if INPUT_VECTOR.y < -0.9:
		ANIM_SPRITE.play("fall")
# Code that runs every frame
func _physics_process(_delta):
	if not DEAD:
		_animate()
		
		# Set x variable of input to right - left
		INPUT_VECTOR.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		INPUT_VECTOR.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		
		# adding gravity to y velocity
		velocity.y += GRAVITY
		
		if Input.is_action_just_pressed("move_up") and is_on_floor():
			velocity.y = JUMP_STRENGTH
			WALK_AUDIO.stop()
			DUST_PARTICLES.emitting = false
			JUMP_AUDIO.play()
			JUMP_AUDIO.pitch_scale = randf_range(3.6, 4.0)
			ANIM_PLAYER.seek(0)
			ANIM_PLAYER.play("JumpSquish")
			_jump_animation()
			
		if Input.is_action_just_pressed("move_up") and not is_on_floor() and PAINT_COLOR == "Blue" and DJUMP_USED == false:
			velocity.y = JUMP_STRENGTH
			WALK_AUDIO.stop()
			DUST_PARTICLES.emitting = false
			JUMP_AUDIO.play()
			JUMP_AUDIO.pitch_scale = randf_range(4.0, 4.2)
			ANIM_PLAYER.seek(0)
			ANIM_PLAYER.play("JumpSquish")
			DJUMP_USED = true
			_jump_animation()
		
		if Input.is_action_pressed("move_right") and velocity.x < SPEED:
			velocity.x += ACCELERATION
			if WALK_AUDIO.playing == false:
				WALK_AUDIO.play()
			if is_on_floor() == false:
				WALK_AUDIO.stop()
		
		elif Input.is_action_pressed("move_left") and velocity.x > (SPEED*-1):
			velocity.x -= ACCELERATION
			if WALK_AUDIO.playing == false:
				WALK_AUDIO.play()
			if is_on_floor() == false:
				WALK_AUDIO.stop()
		else:
			velocity.x = lerpf(velocity.x, 0.0, 0.4)
		
		# move the character according to velocity
		move_and_slide()

func _animate():
	if INPUT_VECTOR.x > 0:
		ANIM_SPRITE.flip_h = false
	elif INPUT_VECTOR.x < 0:
		ANIM_SPRITE.flip_h = true
	
	if is_on_floor():
		DJUMP_USED = false
		if INPUT_VECTOR.x == 0:
			ANIM_SPRITE.play("idle")
			WALK_AUDIO.stop()
			DUST_PARTICLES.emitting = false
		else:
			ANIM_SPRITE.play("walk")
			DUST_PARTICLES.emitting = true
			DUST_PARTICLES.direction.x = -INPUT_VECTOR.x
			
	if INPUT_VECTOR.x < 0:
		ANIM_SPRITE.flip_h = true
	if INPUT_VECTOR.x > 0:
		ANIM_SPRITE.flip_h = false

func _die():
	DEAD = true
	ANIM_PLAYER.play("Death")
	get_parent().get_parent()._restart()
	get_node("Death").play()
	_reset()
	DEAD = false

func _change_color(NEW_COLOR):
	PAINT_COLOR = NEW_COLOR
	if PAINT_COLOR == "Red":
		self.modulate = Color(1,0,0)
		_reset_speed()
		_lock_doors()
		if not FOOD_APPEARED:
			for can in FOOD:
				if not can.COLLECTED:
					can.visible = true
			FOOD_APPEARED = true
	if PAINT_COLOR == "Blue":
		self.modulate = Color(0,0,1)
		SPEED = 900
		_lock_doors()
	if PAINT_COLOR == "Yellow":
		self.modulate = Color(1,1,0)
		_reset_speed()
		if DOORS_LOCKED: #unlock the doors
			for door in DOORS:
				door.set_collision_layer_value(5, 0)
				door.get_node("LockedDoorSprite").visible = false
				door.get_node("UnlockedDoorSprite").play("unlock")
				door.get_node("UnlockAudio").play()
			DOORS_LOCKED = false
	if PAINT_COLOR == "Gray":
		self.modulate = Color(1,1,1)
		_reset_speed()
		_lock_doors()
		
func _lock_doors():
	if not DOORS_LOCKED:
		for door in DOORS:
			door.set_collision_layer_value(5, 1)
			door.get_node("LockedDoorSprite").visible = true
			door.get_node("LockedDoorSprite").play("lock")
			door.get_node("LockAudio").play()
		#DOORS.$LockAudio.play()
			#LOCK_AUDIO.play()
		DOORS_LOCKED = true
		
func _reset_speed():
	SPEED = 600

