extends Node2D

@onready var display_pet_name = $display_pet_name
@onready var hunger_bar = $"hunger bar"
@onready var thirst_bar = $"thirst bar"
@onready var level_label = $"level label"
@onready var save_status = $"save settings/save status"
@onready var save_timer = $"save settings/save timer"


func _ready() -> void:
	display_pet_name.text = Globals.pet_name
	hunger_bar.text = "hunger: " + str(Globals.hunger) + "%" # global variabls so its easier to save 
	thirst_bar.text = "thirst: " + str(Globals.thirst) + "%"
	$cat.standing()
	level_label.text = "level: "+str(Globals.level)
	$"save settings".visible = false
	$"overwrite options".visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.hunger == 0 or Globals.thirst == 0:
		get_tree().change_scene_to_file("res://main_homscreen/death_scene.tscn")
	level_label.text = "level: "+str(floori(Globals.level))

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

func _on_pet_pressed() -> void:
	get_tree().change_scene_to_file("res://water + food + pet screen/pet_scene.tscn")

func save ():
	var file = FileAccess.open(Globals.save_path, FileAccess.WRITE)
	file.store_var(Globals.hunger)
	file.store_var(Globals.thirst)
	file.store_var(Globals.level)
	file.store_var(Globals.pet_name)

func _on_save_pressed() -> void:
	if FileAccess.file_exists(Globals.save_path):
		$"save settings".visible = true
		save_status.text = "this will overwrite the previous save, do you wish to continue?"
		$"overwrite options".visible = true
	else:
		$"save settings".visible = true
		save()
		save_timer.start()
		save_status.text = "save successful!"

func _on_save_timer_timeout() -> void:
	$"save settings".visible = false

func _on_continue_pressed() -> void:
	$"overwrite options".visible = false
	$"save settings".visible = true
	save()
	save_timer.start()
	save_status.text = "save successful!"
	
func _on_go_back_pressed() -> void:
	$"overwrite options".visible = false
	$"save settings".visible = true
	save_timer.start()
	save_status.text = "game not saved"
