extends CanvasLayer

var food_count = 0
var pfood_count = 0
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if Input.is_action_just_pressed("pause"): # Enter key or Escape key
		if paused:
			get_parent().get_node("PauseMenu").unpause()
		else:
			pause()

func update_score(animate):
	# play an animation that makes it immediately large and then
	# slowly shrink back to normal size
	#$FoodCount.text = "Food collected this round: "+str(food_count)
	#$FoodCount.text = "Food collected this round: "+str(food_count-pfood_count)+"\nFood collected overall: "+str(food_count)
	$FoodCount.text = "Food collected this round: "+str(food_count)+"\nFood collected overall: "+str(food_count+pfood_count)
	if animate:
		$AnimationPlayer.play("food_collected")

func pause():
	paused = true
	visible = false
	get_parent().freeze = true
	#print("Pause")
	get_parent().get_node("PauseMenu").visible = true

func _on_pause_button_pressed():
	pause()
