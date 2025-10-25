extends Node2D

@onready var hunger_bar = $"hunger bar"
@onready var thirst_bar = $"thirst bar"
@onready var scene_switch_timer = $"scene switch timer"
@onready var food_text = $"food text"
var scene_timer_started = false

func _process(delta: float) -> void:
	hunger_bar.text = "hunger: " + str(Globals.hunger) + "%"
	thirst_bar.text = "thirst: " + str(Globals.thirst) + "%"
	if Globals.hunger == 100 and not scene_timer_started:
		scene_timer_started = true
		scene_switch_timer.start()
		Globals.level += 0.2
		$cat.jump()
	if Globals.hunger == 100 and scene_timer_started:
		$cat.jump()
		food_text.text = "yay! "+str(Globals.pet_name)+" isn't hungry anymore. "
	else:
		$cat.drinking()
		food_text.text = "keep clicking on the food bowl to feed "+str(Globals.pet_name)+"!"

func _on_scene_switch_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://main_homscreen/main_homescreen.tscn")
	
func _on_thirst_timer_timeout() -> void:
	Globals.thirst = max(Globals.thirst - 1,0)
	thirst_bar.text = "thirst: " + str(Globals.thirst) + "%"

func _on_food_bowl_pressed() -> void:
	Globals.hunger = min(Globals.hunger + 10,100)
	hunger_bar.text = "hunger: " + str(Globals.hunger) + "%"
