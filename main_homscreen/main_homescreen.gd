extends Node2D

@onready var display_pet_name = $display_pet_name
@onready var hunger_bar = $"hunger bar"
@onready var thirst_bar = $"thirst bar"


func _ready() -> void:
	display_pet_name.text = Globals.pet_name
	hunger_bar.text = "hunger: " + str(Globals.hunger) + "%" # global variabls so its easier to save 
	thirst_bar.text = "thirst: " + str(Globals.thirst) + "%"
	$cat.standing()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.hunger == 0 or Globals.thirst == 0:
		get_tree().change_scene_to_file("res://main_homscreen/death_scene.tscn")

func _on_hunger_timer_timeout() -> void:
	Globals.hunger = max(Globals.hunger - 1, 0)  # decrease by 1 but don’t go below 0
	hunger_bar.text = "hunger: " + str(Globals.hunger) + "%"

func _on_thirst_timer_timeout() -> void:
	Globals.thirst = max(Globals.thirst - 1, 0)  # decrease by 1 but don’t go below 0
	thirst_bar.text = "thirst: " + str(Globals.thirst) + "%"

func _on_quit_pressed() -> void: # controls the quit 
	get_tree().quit()
	
func _on_give_water_pressed() -> void:
	get_tree().change_scene_to_file("res://water + food + pet screen/water_scene.tscn")

func _on_give_food_pressed() -> void:
	get_tree().change_scene_to_file("res://water + food + pet screen/food_scene.tscn")
