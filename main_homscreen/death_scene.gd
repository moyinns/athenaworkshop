extends Node2D

@onready var death_text = $"death text"
@onready var death_timer = $"death timer"      # your Timer node
@onready var timer_count = death_timer.time_left

func _ready() -> void:
	$cat.die()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer_count = round(death_timer.time_left)
	if Globals.hunger == 0:
		death_text.text = "oh no! you killed " + Globals.pet_name + " by forgetting to feed them! make sure to rememeber to feed them next time!.
		transporting you back to the main screen in " + str(timer_count) + " seconds"
	if Globals.thirst == 0:
		death_text.text = "oh no! you killed " + Globals.pet_name + " by forgetting to give them water! make sure to rememeber to give them water next time!.
		transporting you back to the main screen in " + str(timer_count) + " seconds"	
	

func _on_death_timer_timeout() -> void:
	Globals.hunger = 50
	Globals.thirst = 50
	get_tree().change_scene_to_file("res://opening_screen/opening_screen.tscn")
