extends CanvasLayer

var food_count = 0
var pfood_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	pass

func update_score(score, animate):
	# play an animation that makes it immediately large and then slowly shrink back to normal size
	#food_count+=1
	$FoodCount.text = "Food collected: "+str(score)
	if animate:
		$AnimationPlayer.play("food_collected")
