extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func update_score(score, animate):
	# play an animation that makes it immediately large and then slowly shrink back to normal size
	$FoodCount.text = "Food collected: "+str(score)
	if animate:
		$AnimationPlayer.play("food_collected")