extends Area2D

@export var COLOR = "Red"
@onready var BUCKET_SPRITE = $BucketSprite

func _physics_process(_delta):
	#BUCKET_SPRITE.play("idle")
	pass

func _on_body_entered(body):
	if body.PAINT_COLOR != COLOR:
		$BucketSplashAudio.play()
		BUCKET_SPRITE.play("splash")
		body._change_color(COLOR)

func _on_bucket_sprite_animation_finished():
	if BUCKET_SPRITE.animation == "splash":
		BUCKET_SPRITE.play("idle")
