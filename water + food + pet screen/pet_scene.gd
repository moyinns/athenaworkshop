extends Node2D

@onready var hunger_bar = $"hunger bar"
@onready var thirst_bar = $"thirst bar"
@onready var scene_switch_timer = $"scene switch timer"
@onready var pet_text = $"pet text"
var timer_started = false
var paw = preload("res://water + food + pet screen/paw cursor.png") # this is a texture 2d, therefore, cannot change the size
var paw_img = paw.get_image()


func _ready() -> void:
	paw_img.resize(64,64)
	paw = ImageTexture.create_from_image(paw_img) # converts it back to a 2d texture

func _process(delta: float) -> void:
	if Globals.hunger == 0 or Globals.thirst == 0:
		get_tree().change_scene_to_file("res://main_homscreen/death_scene.tscn")
	$cat.pet()
	hunger_bar.text = "hunger: " + str(Globals.hunger) + "%"
	thirst_bar.text = "thirst: " + str(Globals.thirst) + "%"
	if not timer_started:
		pet_text.text = "hover your cursor over "+str(Globals.pet_name)+" to pet them!"

func _on_hunger_timer_timeout() -> void:
	Globals.hunger = max(Globals.hunger - 1, 0)  # decrease by 1 but don’t go below 0
	hunger_bar.text = "hunger: " + str(Globals.hunger) + "%"

func _on_thirst_timer_timeout() -> void:
	Globals.thirst = max(Globals.thirst - 1, 0)  # decrease by 1 but don’t go below 0
	thirst_bar.text = "thirst: " + str(Globals.thirst) + "%"

func _on_area_2d_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(paw)
	timer_started = true
	scene_switch_timer.start()
	pet_text.text = "keep hovering your cursor over "+str(Globals.pet_name)+" to pet them!"

func _on_area_2d_mouse_shape_exited(shape_idx: int) -> void:
	Input.set_custom_mouse_cursor(null)
	timer_started = false
	scene_switch_timer.stop()
	pet_text.text = "hover your cursor over "+str(Globals.pet_name)+" to pet them!"
	
func _on_scene_switch_timer_timeout() -> void:
	Globals.level += 0.5
	get_tree().change_scene_to_file("res://main_homscreen/main_homescreen.tscn")
