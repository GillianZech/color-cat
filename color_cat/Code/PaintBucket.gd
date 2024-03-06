extends Area2D

@export var COLOR = "Red"
@onready var BUCKET_SPRITE = $BucketSprite

func _physics_process(_delta):
	_animate()
	
func _animate():
	BUCKET_SPRITE.play("idle")

func _on_body_entered(body):
	if body.PAINT_COLOR != COLOR:
		$BucketSplashAudio.play()
		#BUCKET_SPRITE.stop()
		BUCKET_SPRITE.play("splash")
		body._change_color(COLOR)
