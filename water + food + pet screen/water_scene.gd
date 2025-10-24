extends Node2D

@onready var hunger_bar = $"hunger bar"
@onready var thirst_bar = $"thirst bar"
@onready var scene_switch_timer = $"scene switch timer"
@onready var water_text = $"water text"
var scene_timer_started = false

func _process(delta: float) -> void:
	hunger_bar.text = "hunger: " + str(Globals.hunger) + "%" 
	thirst_bar.text = "thirst: " + str(Globals.thirst) + "%"
	if Globals.thirst == 100 and not scene_timer_started:
		scene_timer_started = true
		scene_switch_timer.start()
		$cat.jump()
	if Globals.thirst == 100 and scene_timer_started:
		water_text.text = "yay! "+str(Globals.pet_name)+" isn't thirsty anymore. "
		$cat.jump()
	else:
		water_text.text = "keep clicking on the water bowl to quench "+str(Globals.pet_name)+"'s thirst!"
		$cat.drinking()

func _on_scene_switch_timer_timeout() -> void:
			get_tree().change_scene_to_file("res://main_homscreen/main_homescreen.tscn")
		
func _on_hunger_timer_timeout() -> void:
	Globals.hunger = max(Globals.hunger - 1, 0)  # this command returns whichever number is larger
	hunger_bar.text = "hunger: " + str(Globals.hunger) + "%"

func _on_water_bowl_pressed() -> void:
	Globals.thirst = min(Globals.thirst + 5, 100) # this command returns whichever number is smaller
	thirst_bar.text = "thirst: " + str(Globals.thirst) + "%"
